import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class ImageStorageService {
  Future<String> savePickedImage(XFile image) async {
    final memoryDirectory = await _memoryImagesDirectory();
    final extension = p.extension(image.path).isEmpty
        ? '.jpg'
        : p.extension(image.path).toLowerCase();
    final fileName =
        '${DateTime.now().microsecondsSinceEpoch}$extension';
    final destination = File(p.join(memoryDirectory.path, fileName));
    await File(image.path).copy(destination.path);
    return destination.path;
  }

  Future<void> deleteManagedImages(List<String> imagePaths) async {
    final memoryDirectory = await _memoryImagesDirectory();
    for (final imagePath in imagePaths) {
      if (!p.isWithin(memoryDirectory.path, imagePath)) {
        continue;
      }

      final file = File(imagePath);
      if (await file.exists()) {
        await file.delete();
      }
    }
  }

  Future<Directory> _memoryImagesDirectory() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final memoryDirectory = Directory(
      p.join(documentsDirectory.path, 'memory_images'),
    );
    if (!await memoryDirectory.exists()) {
      await memoryDirectory.create(recursive: true);
    }
    return memoryDirectory;
  }
}
