import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../data/models/memory_item.dart';
import '../../../ui/atoms/empty_state.dart';
import '../../../ui/molecules/memory_list_tile.dart';
import '../providers/memory_providers.dart';
import 'memory_detail_page.dart';

class MemoryListPage extends ConsumerWidget {
  const MemoryListPage({
    required this.onViewOnMap,
    super.key,
  });

  final VoidCallback onViewOnMap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final memories = ref.watch(memoryListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kỷ niệm đã lưu'),
      ),
      body: memories.when(
        data: (items) {
          if (items.isEmpty) {
            return const EmptyState(
              title: 'Chưa có kỷ niệm',
              message: 'Nhấn giữ trên bản đồ hoặc tìm địa điểm để tạo kỷ niệm.',
            );
          }

          return RefreshIndicator(
            onRefresh: () => ref.read(memoryListProvider.notifier).refresh(),
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final memory = items[index];
                return Dismissible(
                  key: ValueKey(memory.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 24),
                    color: Theme.of(context).colorScheme.errorContainer,
                    child: const Icon(Icons.delete_outline),
                  ),
                  confirmDismiss: (_) => _confirmDelete(context),
                  onDismissed: (_) {
                    ref.read(memoryListProvider.notifier).delete(memory.id);
                  },
                  child: MemoryListTile(
                    memory: memory,
                    onTap: () => _openDetail(context, memory),
                    onViewOnMap: () {
                      ref.read(selectedMapTargetProvider.notifier).state =
                          LatLng(memory.latitude, memory.longitude);
                      onViewOnMap();
                    },
                  ),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text(error.toString())),
      ),
    );
  }

  Future<void> _openDetail(BuildContext context, MemoryItem memory) async {
    final shouldViewOnMap = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (context) => MemoryDetailPage(memory: memory),
      ),
    );
    if (shouldViewOnMap == true) {
      onViewOnMap();
    }
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Xóa kỷ niệm?'),
        content: const Text('Kỷ niệm và ảnh đã lưu sẽ bị xóa khỏi thiết bị.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Hủy'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Xóa'),
          ),
        ],
      ),
    );

    return confirmed ?? false;
  }
}
