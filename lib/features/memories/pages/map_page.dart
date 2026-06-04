import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/config/app_config.dart';
import '../../../data/models/map_search_result.dart';
import '../../../data/models/memory_item.dart';
import '../../../ui/molecules/memory_search_field.dart';
import '../../../ui/organisms/memory_form_sheet.dart';
import '../../../ui/organisms/memory_map_view.dart';
import '../providers/location_provider.dart';
import '../providers/memory_providers.dart';
import '../providers/search_provider.dart';
import 'memory_detail_page.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  final _mapController = MapController();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(locationControllerProvider.notifier).requestCurrentLocation();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<LatLng?>(selectedMapTargetProvider, (_, target) {
      if (target == null) {
        return;
      }
      _moveTo(target);
      ref.read(selectedMapTargetProvider.notifier).state = null;
    });

    ref.listen(locationControllerProvider, (_, next) {
      next.whenOrNull(
        data: (location) {
          if (location != null) {
            _moveTo(location);
          }
        },
        error: (error, _) {
          _showSnackBar(error.toString());
        },
      );
    });

    final memories = ref.watch(memoryListProvider);
    final location = ref.watch(locationControllerProvider).valueOrNull;
    final searchState = ref.watch(mapSearchControllerProvider);

    return Scaffold(
      body: Stack(
        children: [
          memories.when(
            data: (items) => MemoryMapView(
              mapController: _mapController,
              memories: items,
              currentLocation: location,
              onLongPress: (point) => _openMemoryForm(point),
              onMemoryTap: _openMemoryDetail,
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Center(child: Text(error.toString())),
          ),
          Positioned(
            top: MediaQuery.paddingOf(context).top + 12,
            left: 16,
            right: 16,
            child: Column(
              children: [
                MemorySearchField(
                  controller: _searchController,
                  onChanged: (query) {
                    ref.read(mapSearchControllerProvider.notifier).search(query);
                  },
                  onClear: () {
                    ref.read(mapSearchControllerProvider.notifier).clear();
                  },
                ),
                _SearchResultsPanel(
                  state: searchState,
                  onSelected: _handleSearchSelection,
                ),
              ],
            ),
          ),
          if (!AppConfig.hasMapTilerKey)
            const Positioned(
              left: 16,
              right: 16,
              bottom: 96,
              child: _MissingApiKeyBanner(),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ref.read(locationControllerProvider.notifier).requestCurrentLocation();
        },
        icon: const Icon(Icons.my_location),
        label: const Text('My Location'),
      ),
    );
  }

  void _moveTo(LatLng target) {
    _mapController.move(target, AppConfig.defaultZoom);
  }

  Future<void> _openMemoryForm(LatLng point, {String? initialTitle}) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => MemoryFormSheet(
        coordinate: point,
        initialTitle: initialTitle,
      ),
    );
  }

  void _handleSearchSelection(MapSearchResult result) {
    _searchController.text = result.name;
    ref.read(mapSearchControllerProvider.notifier).clear();
    _moveTo(result.coordinate);
    _openMemoryForm(result.coordinate, initialTitle: result.name);
  }

  Future<void> _openMemoryDetail(MemoryItem memory) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => MemoryDetailPage(memory: memory),
      ),
    );
  }

  void _showSnackBar(String message) {
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class _SearchResultsPanel extends StatelessWidget {
  const _SearchResultsPanel({
    required this.state,
    required this.onSelected,
  });

  final AsyncValue<List<MapSearchResult>> state;
  final ValueChanged<MapSearchResult> onSelected;

  @override
  Widget build(BuildContext context) {
    return state.when(
      data: (results) {
        if (results.isEmpty) {
          return const SizedBox.shrink();
        }

        return Card(
          margin: const EdgeInsets.only(top: 8),
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: results.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final result = results[index];
              return ListTile(
                onTap: () => onSelected(result),
                title: Text(result.name),
                subtitle: Text(result.address ?? ''),
                leading: const Icon(Icons.search),
              );
            },
          ),
        );
      },
      loading: () => const Card(
        margin: EdgeInsets.only(top: 8),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: LinearProgressIndicator(),
        ),
      ),
      error: (error, _) => Card(
        margin: const EdgeInsets.only(top: 8),
        child: ListTile(
          leading: const Icon(Icons.error_outline),
          title: const Text('Không tìm được địa điểm'),
          subtitle: Text(error.toString()),
        ),
      ),
    );
  }
}

class _MissingApiKeyBanner extends StatelessWidget {
  const _MissingApiKeyBanner();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.errorContainer,
      child: const Padding(
        padding: EdgeInsets.all(12),
        child: Text(
          'Chưa có MAPTILER_API_KEY. Chạy app với '
          '--dart-define=MAPTILER_API_KEY=your_key.',
        ),
      ),
    );
  }
}
