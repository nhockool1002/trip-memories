import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../data/models/memory_item.dart';
import '../../../ui/atoms/app_button.dart';
import '../../../ui/molecules/memory_image_grid.dart';
import '../../../ui/organisms/memory_form_sheet.dart';
import '../providers/memory_providers.dart';

class MemoryDetailPage extends ConsumerStatefulWidget {
  const MemoryDetailPage({
    required this.memory,
    super.key,
  });

  final MemoryItem memory;

  @override
  ConsumerState<MemoryDetailPage> createState() => _MemoryDetailPageState();
}

class _MemoryDetailPageState extends ConsumerState<MemoryDetailPage> {
  late MemoryItem _memory;

  @override
  void initState() {
    super.initState();
    _memory = widget.memory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_memory.title),
        actions: [
          IconButton(
            tooltip: 'Chỉnh sửa',
            onPressed: _editMemory,
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            tooltip: 'Xóa',
            onPressed: _deleteMemory,
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(_memory.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            '${_memory.latitude.toStringAsFixed(6)}, '
            '${_memory.longitude.toStringAsFixed(6)}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          if (_memory.note.isNotEmpty)
            Text(_memory.note, style: Theme.of(context).textTheme.bodyLarge)
          else
            Text(
              'Chưa có ghi chú.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          const SizedBox(height: 20),
          MemoryImageGrid(imagePaths: _memory.imagePaths),
          const SizedBox(height: 24),
          AppButton(
            label: 'Xem trên bản đồ',
            onPressed: _viewOnMap,
            icon: Icons.map_outlined,
          ),
        ],
      ),
    );
  }

  Future<void> _editMemory() async {
    final updatedMemory = await showModalBottomSheet<MemoryItem>(
      context: context,
      isScrollControlled: true,
      builder: (context) => MemoryFormSheet(
        coordinate: LatLng(_memory.latitude, _memory.longitude),
        initialMemory: _memory,
      ),
    );

    if (updatedMemory != null && mounted) {
      setState(() => _memory = updatedMemory);
    }
  }

  Future<void> _deleteMemory() async {
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

    if (confirmed != true) {
      return;
    }

    await ref.read(memoryListProvider.notifier).delete(_memory.id);
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void _viewOnMap() {
    ref.read(selectedMapTargetProvider.notifier).state =
        LatLng(_memory.latitude, _memory.longitude);
    Navigator.of(context).pop(true);
  }
}
