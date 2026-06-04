import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';

import '../../core/config/app_config.dart';
import '../../core/utils/date_time_id.dart';
import '../../data/models/memory_item.dart';
import '../../features/memories/providers/memory_providers.dart';
import '../atoms/app_button.dart';
import '../atoms/app_text_field.dart';
import '../molecules/memory_image_grid.dart';

class MemoryFormSheet extends ConsumerStatefulWidget {
  const MemoryFormSheet({
    required this.coordinate,
    super.key,
    this.initialTitle,
    this.initialMemory,
  });

  final LatLng coordinate;
  final String? initialTitle;
  final MemoryItem? initialMemory;

  @override
  ConsumerState<MemoryFormSheet> createState() => _MemoryFormSheetState();
}

class _MemoryFormSheetState extends ConsumerState<MemoryFormSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  final _picker = ImagePicker();
  late List<String> _imagePaths;
  var _isSaving = false;

  @override
  void initState() {
    super.initState();
    final initialMemory = widget.initialMemory;
    _titleController.text = initialMemory?.title ?? widget.initialTitle ?? '';
    _noteController.text = initialMemory?.note ?? '';
    _imagePaths = [...?initialMemory?.imagePaths];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.initialMemory != null;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.viewInsetsOf(context).bottom + 16,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isEditing ? 'Chỉnh sửa kỷ niệm' : 'Thêm kỷ niệm',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              AppTextField(
                controller: _titleController,
                label: 'Tên địa điểm',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Vui lòng nhập tên địa điểm';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              AppTextField(
                controller: _noteController,
                label: 'Ghi chú',
                maxLines: 4,
              ),
              const SizedBox(height: 16),
              MemoryImageGrid(
                imagePaths: _imagePaths,
                onRemove: (imagePath) {
                  setState(() => _imagePaths.remove(imagePath));
                },
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  OutlinedButton.icon(
                    onPressed: _canAddMoreImages
                        ? () => _pickImage(ImageSource.gallery)
                        : null,
                    icon: const Icon(Icons.photo_library_outlined),
                    label: const Text('Thư viện'),
                  ),
                  OutlinedButton.icon(
                    onPressed: _canAddMoreImages
                        ? () => _pickImage(ImageSource.camera)
                        : null,
                    icon: const Icon(Icons.camera_alt_outlined),
                    label: const Text('Camera'),
                  ),
                  Text(
                    '${_imagePaths.length}/${AppConfig.maxImagesPerMemory} ảnh',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              AppButton(
                label: _isSaving ? 'Đang lưu...' : 'Lưu',
                onPressed: _isSaving ? null : _save,
                icon: Icons.save_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool get _canAddMoreImages =>
      _imagePaths.length < AppConfig.maxImagesPerMemory;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await _picker.pickImage(source: source, imageQuality: 85);
    if (pickedImage == null) {
      return;
    }

    final storageService = ref.read(imageStorageServiceProvider);
    final savedPath = await storageService.savePickedImage(pickedImage);
    if (!mounted) {
      return;
    }
    setState(() => _imagePaths.add(savedPath));
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSaving = true);
    final now = DateTime.now();
    final initialMemory = widget.initialMemory;
    final memory = initialMemory == null
        ? MemoryItem(
            id: createDateTimeId(),
            title: _titleController.text.trim(),
            note: _noteController.text.trim(),
            latitude: widget.coordinate.latitude,
            longitude: widget.coordinate.longitude,
            imagePaths: _imagePaths,
            createdAt: now,
            updatedAt: now,
          )
        : initialMemory.copyWith(
            title: _titleController.text.trim(),
            note: _noteController.text.trim(),
            imagePaths: _imagePaths,
            updatedAt: now,
          );

    await ref.read(memoryListProvider.notifier).save(memory);
    await _deleteRemovedImages(initialMemory);

    if (mounted) {
      Navigator.of(context).pop(memory);
    }
  }

  Future<void> _deleteRemovedImages(MemoryItem? initialMemory) async {
    if (initialMemory == null) {
      return;
    }

    final removedImagePaths = initialMemory.imagePaths
        .where((imagePath) => !_imagePaths.contains(imagePath))
        .toList();
    await ref
        .read(imageStorageServiceProvider)
        .deleteManagedImages(removedImagePaths);
  }
}
