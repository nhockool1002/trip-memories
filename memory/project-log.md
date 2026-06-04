# Trip Memories - Project Log

## 2026-06-04
- Khởi động dự án từ tài liệu đặc tả `specification requirement.txt`.
- Chốt stack giai đoạn 1: Flutter, MapTiler, Riverpod, sqflite.
- Tạo cấu trúc tài liệu `plan/` và `memory/` để lưu roadmap, task, kiến trúc, nhật ký và quyết định.
- Môi trường hiện tại chưa có `flutter`, `dart` hoặc `fvm` trong PATH, nên project được dựng thủ công thay vì chạy `flutter create`.
- Thêm `pubspec.yaml`, `analysis_options.yaml`, `.gitignore`, `README.md` và source Flutter theo kiến trúc Atomic Design.
- Hoàn thành các luồng chính ở mức source: MapTiler map, My Location, tìm kiếm địa điểm, tạo/sửa/xóa memory, danh sách, chi tiết, ảnh local và focus marker.
- Thêm cấu hình quyền nền tảng trong `ios/Runner/Info.plist` và `android/app/src/main/AndroidManifest.xml`.
- Thêm test model `MemoryItem`; chưa thể chạy `flutter analyze` hoặc `flutter test` do thiếu Flutter CLI.

## Quy ước ghi log
- Mỗi milestone hoặc thay đổi phạm vi cần thêm một mục mới theo ngày.
- Mỗi mục nên ghi rõ: đã làm gì, quyết định nào được đưa ra, còn rủi ro gì.
- Không lưu secret hoặc API key thật trong nhật ký.
