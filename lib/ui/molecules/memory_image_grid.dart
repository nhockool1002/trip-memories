import 'dart:io';

import 'package:flutter/material.dart';

class MemoryImageGrid extends StatelessWidget {
  const MemoryImageGrid({
    required this.imagePaths,
    super.key,
    this.onRemove,
  });

  final List<String> imagePaths;
  final ValueChanged<String>? onRemove;

  @override
  Widget build(BuildContext context) {
    if (imagePaths.isEmpty) {
      return const SizedBox.shrink();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: imagePaths.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final imagePath = imagePaths[index];
        return Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(File(imagePath), fit: BoxFit.cover),
            ),
            if (onRemove != null)
              Positioned(
                top: 4,
                right: 4,
                child: IconButton.filledTonal(
                  visualDensity: VisualDensity.compact,
                  onPressed: () => onRemove?.call(imagePath),
                  icon: const Icon(Icons.close),
                ),
              ),
          ],
        );
      },
    );
  }
}
