# Trip Memories - Feature History

## Documentation Foundation
- Trạng thái: hoàn thành.
- Mục tiêu: tạo nơi lưu kế hoạch tổng thể, task breakdown, kiến trúc, nhật ký và quyết định.
- Kiểm chứng: các file markdown tồn tại trong `plan/` và `memory/`.

## Flutter Bootstrap
- Trạng thái: hoàn thành ở mức source thủ công.
- Mục tiêu: tạo project Flutter, theme, routing và Atomic Design skeleton.
- File chính: `pubspec.yaml`, `lib/main.dart`, `lib/app/`, `lib/ui/`.
- Ghi chú: chưa chạy được `flutter create` vì Flutter CLI chưa có trong PATH.

## Map & Location
- Trạng thái: hoàn thành ở mức source.
- Mục tiêu: hiển thị MapTiler map, vị trí hiện tại và My Location.
- File chính: `lib/ui/organisms/memory_map_view.dart`, `lib/features/memories/pages/map_page.dart`, `lib/data/services/location_service.dart`.
- Kiểm chứng: luồng xin quyền, lấy vị trí và nút My Location đã được nối bằng Riverpod provider.

## Local Data
- Trạng thái: hoàn thành ở mức source.
- Mục tiêu: model `MemoryItem`, sqflite database, repository CRUD và lưu ảnh local.
- File chính: `lib/data/models/memory_item.dart`, `lib/data/local/app_database.dart`, `lib/data/repositories/memory_repository.dart`, `lib/data/services/image_storage_service.dart`.
- Kiểm chứng: có test serialize/deserialize cho `MemoryItem`.

## Memory Features
- Trạng thái: hoàn thành ở mức source.
- Mục tiêu: thêm, sửa, xóa, xem danh sách, xem chi tiết và focus memory trên bản đồ.
- File chính: `lib/ui/organisms/memory_form_sheet.dart`, `lib/features/memories/pages/memory_list_page.dart`, `lib/features/memories/pages/memory_detail_page.dart`.
- Kiểm chứng: UI đã nối form, list, detail, delete và selected map target provider.

## Search & Polish
- Trạng thái: hoàn thành ở mức source, chờ chạy thực tế khi có Flutter CLI.
- Mục tiêu: tìm kiếm địa điểm MapTiler, xử lý edge cases và kiểm thử.
- File chính: `lib/data/services/maptiler_service.dart`, `lib/features/memories/providers/search_provider.dart`, `README.md`.
- Kiểm chứng: đã xử lý thiếu API key bằng banner và không hardcode key trong source.
