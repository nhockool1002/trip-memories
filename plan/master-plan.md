# Trip Memories - Master Plan

## Mục tiêu giai đoạn 1
Xây dựng ứng dụng Flutter ghi nhớ địa điểm du lịch yêu thích, ưu tiên iOS, lưu toàn bộ dữ liệu cá nhân trên thiết bị.

## Stack đã chốt
- Framework: Flutter stable, Dart.
- Bản đồ: MapTiler qua `flutter_map`.
- State management: Riverpod.
- Local database: `sqflite`.
- Lưu ảnh: copy vào app documents bằng `path_provider`.

## Phạm vi MVP
- Hiển thị bản đồ, vị trí hiện tại và nút My Location.
- Tìm kiếm địa điểm qua MapTiler Geocoding.
- Long-press hoặc chọn kết quả tìm kiếm để tạo kỷ niệm.
- Lưu tên, ghi chú, tọa độ và tối đa 5 ảnh cho mỗi kỷ niệm.
- Danh sách, chi tiết, chỉnh sửa, xóa và focus lại marker trên bản đồ.

## Roadmap
### Tuần 1 - Nền tảng
- Khởi tạo Flutter project.
- Thiết lập theme, routing, Atomic Design skeleton.
- Tạo tài liệu `plan/` và `memory/`.

### Tuần 2 - Bản đồ và vị trí
- Tích hợp MapTiler map.
- Xin quyền vị trí, lấy vị trí hiện tại.
- Hiển thị marker vị trí người dùng và nút My Location.

### Tuần 3 - Dữ liệu local và marker
- Thiết kế model `MemoryItem`.
- Tạo sqflite schema và repository CRUD.
- Tạo marker bằng long-press và form lưu kỷ niệm.

### Tuần 4 - Ảnh và danh sách
- Chọn ảnh từ camera/gallery.
- Copy ảnh vào thư mục documents.
- Hiển thị danh sách, chi tiết, chỉnh sửa và xóa.

### Tuần 5 - Tìm kiếm và hoàn thiện
- Tích hợp MapTiler Geocoding.
- Focus bản đồ từ kết quả tìm kiếm hoặc danh sách.
- Kiểm thử iOS, xử lý edge cases và kiểm tra Android cơ bản.

## Rủi ro chính
- MapTiler API key cần được truyền qua cấu hình runtime, không hardcode.
- iOS permission cần khai báo đầy đủ trong `Info.plist`.
- Ảnh local cần được dọn khi memory bị xóa để tránh rác dữ liệu.
- `sqflite` migration cần được quản lý từ đầu để tránh mất dữ liệu khi nâng phiên bản.

## Định nghĩa hoàn thành
- Các luồng chính chạy được trên simulator iOS.
- Dữ liệu vẫn còn sau khi tắt mở app.
- Không có lỗi analyzer nghiêm trọng trong source Dart.
- `memory/` được cập nhật khi hoàn thành milestone hoặc thay đổi quyết định kỹ thuật.
