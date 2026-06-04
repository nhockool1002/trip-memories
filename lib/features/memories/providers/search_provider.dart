import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/map_search_result.dart';
import '../../../data/services/maptiler_service.dart';

final mapTilerServiceProvider = Provider<MapTilerService>((ref) {
  return const MapTilerService();
});

final mapSearchControllerProvider =
    StateNotifierProvider<MapSearchController, AsyncValue<List<MapSearchResult>>>(
  (ref) => MapSearchController(ref.watch(mapTilerServiceProvider)),
);

class MapSearchController
    extends StateNotifier<AsyncValue<List<MapSearchResult>>> {
  MapSearchController(this._mapTilerService) : super(const AsyncData([]));

  final MapTilerService _mapTilerService;

  Future<void> search(String query) async {
    if (query.trim().length < 2) {
      clear();
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _mapTilerService.searchPlaces(query));
  }

  void clear() {
    state = const AsyncData([]);
  }
}
