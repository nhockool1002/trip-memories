import 'package:flutter_test/flutter_test.dart';
import 'package:trip_memories/data/models/memory_item.dart';

void main() {
  test('MemoryItem serializes and deserializes image paths', () {
    final createdAt = DateTime.parse('2026-06-04T20:00:00.000');
    final updatedAt = DateTime.parse('2026-06-04T21:00:00.000');
    final memory = MemoryItem(
      id: '1',
      title: 'Đà Lạt',
      note: 'Một buổi sáng nhiều sương.',
      latitude: 11.9404,
      longitude: 108.4583,
      imagePaths: const ['/app/a.jpg', '/app/b.jpg'],
      createdAt: createdAt,
      updatedAt: updatedAt,
    );

    final restored = MemoryItem.fromMap(memory.toMap());

    expect(restored.id, memory.id);
    expect(restored.title, memory.title);
    expect(restored.note, memory.note);
    expect(restored.latitude, memory.latitude);
    expect(restored.longitude, memory.longitude);
    expect(restored.imagePaths, memory.imagePaths);
    expect(restored.createdAt, memory.createdAt);
    expect(restored.updatedAt, memory.updatedAt);
  });
}
