# Trip Memories

Trip Memories là ứng dụng Flutter lưu kỷ niệm du lịch trên thiết bị, gồm bản đồ MapTiler, vị trí hiện tại, tìm kiếm địa điểm, marker kỷ niệm, ảnh local, danh sách và chi tiết.

## Cấu hình
Không hardcode MapTiler API key vào source. Chạy app với:

```sh
flutter run --dart-define=MAPTILER_API_KEY=your_key
```

## Cài đặt sau khi có Flutter SDK
Môi trường hiện tại chưa có `flutter` trong PATH, nên source được dựng thủ công. Sau khi cài Flutter stable hoặc cấu hình PATH, chạy:

```sh
flutter pub get
flutter create . --platforms=ios,android
flutter analyze
flutter test
```

Sau khi chạy `flutter create .`, kiểm tra lại các permission trong:
- `ios/Runner/Info.plist`
- `android/app/src/main/AndroidManifest.xml`

## Cấu trúc chính
- `lib/app/`: app entry, theme, routes.
- `lib/core/`: config, permission và utility dùng chung.
- `lib/data/`: models, sqflite database, repositories, services.
- `lib/features/memories/`: pages và Riverpod providers cho memory/map/search.
- `lib/ui/`: Atomic Design components.
- `plan/`: roadmap, task breakdown và kiến trúc.
- `memory/`: nhật ký, lịch sử feature và quyết định kỹ thuật.
