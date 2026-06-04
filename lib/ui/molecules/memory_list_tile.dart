import 'dart:io';

import 'package:flutter/material.dart';

import '../../data/models/memory_item.dart';

class MemoryListTile extends StatelessWidget {
  const MemoryListTile({
    required this.memory,
    required this.onTap,
    required this.onViewOnMap,
    super.key,
  });

  final MemoryItem memory;
  final VoidCallback onTap;
  final VoidCallback onViewOnMap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        onTap: onTap,
        leading: _MemoryThumbnail(imagePaths: memory.imagePaths),
        title: Text(memory.title),
        subtitle: Text(
          memory.note.isEmpty
              ? '${memory.latitude.toStringAsFixed(4)}, ${memory.longitude.toStringAsFixed(4)}'
              : memory.note,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          tooltip: 'Xem trên bản đồ',
          onPressed: onViewOnMap,
          icon: const Icon(Icons.map_outlined),
        ),
      ),
    );
  }
}

class _MemoryThumbnail extends StatelessWidget {
  const _MemoryThumbnail({required this.imagePaths});

  final List<String> imagePaths;

  @override
  Widget build(BuildContext context) {
    if (imagePaths.isEmpty) {
      return CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        child: const Icon(Icons.place_outlined),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.file(
        File(imagePaths.first),
        width: 56,
        height: 56,
        fit: BoxFit.cover,
      ),
    );
  }
}
