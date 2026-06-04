import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../data/local/app_database.dart';
import '../../../data/models/memory_item.dart';
import '../../../data/repositories/memory_repository.dart';
import '../../../data/services/image_storage_service.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase.instance;
});

final imageStorageServiceProvider = Provider<ImageStorageService>((ref) {
  return ImageStorageService();
});

final memoryRepositoryProvider = Provider<MemoryRepository>((ref) {
  return MemoryRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(imageStorageServiceProvider),
  );
});

final selectedMapTargetProvider = StateProvider<LatLng?>((ref) => null);

final memoryListProvider =
    AsyncNotifierProvider<MemoryListController, List<MemoryItem>>(
  MemoryListController.new,
);

class MemoryListController extends AsyncNotifier<List<MemoryItem>> {
  late final MemoryRepository _repository;

  @override
  Future<List<MemoryItem>> build() async {
    _repository = ref.watch(memoryRepositoryProvider);
    return _repository.getAll();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_repository.getAll);
  }

  Future<void> save(MemoryItem memory) async {
    await _repository.save(memory);
    await refresh();
  }

  Future<void> delete(String id) async {
    await _repository.delete(id);
    await refresh();
  }
}
