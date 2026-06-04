# Trip Memories - Task Breakdown

## Epic 1 - Project Foundation
- [x] Tạo thư mục `plan/` và `memory/`.
- [x] Khởi tạo Flutter project ở mức source thủ công do môi trường chưa có Flutter CLI.
- [x] Cấu hình dependencies chính trong `pubspec.yaml`.
- [x] Thiết lập theme Material 3 và navigation.
- [x] Dựng Atomic Design skeleton.

## Epic 2 - Map & Location
- [x] Cấu hình MapTiler tile layer.
- [x] Tạo `MapPage` và organism bản đồ.
- [x] Xin quyền vị trí bằng `geolocator`.
- [x] Hiển thị vị trí hiện tại.
- [x] Thêm nút My Location.
- [x] Xử lý trường hợp quyền bị từ chối.

## Epic 3 - Local Storage
- [x] Tạo `MemoryItem` model.
- [x] Tạo sqflite database helper.
- [x] Tạo repository CRUD.
- [x] Tạo provider danh sách memory.
- [x] Viết test cho model ở mức phù hợp.

## Epic 4 - Pin & Note
- [x] Long-press trên bản đồ để tạo marker tạm.
- [x] Hiển thị form thêm/sửa kỷ niệm.
- [x] Validate tên địa điểm bắt buộc.
- [x] Lưu kỷ niệm xuống database.
- [x] Hiển thị marker đã lưu trên bản đồ.

## Epic 5 - Images
- [x] Chọn ảnh từ thư viện.
- [x] Chụp ảnh bằng camera.
- [x] Copy ảnh vào app documents.
- [x] Giới hạn tối đa 5 ảnh cho mỗi memory.
- [x] Xóa file ảnh khi memory bị xóa.

## Epic 6 - List, Detail & Search
- [x] Hiển thị danh sách memory.
- [x] Mở màn chi tiết.
- [x] Chỉnh sửa và xóa memory.
- [x] Focus marker từ danh sách về bản đồ.
- [x] Tìm kiếm địa điểm bằng MapTiler Geocoding.
- [x] Tạo memory từ kết quả tìm kiếm.

## Epic 7 - Hardening
- [x] Kiểm tra permission iOS/Android ở mức file cấu hình.
- [ ] Chạy `flutter analyze` (blocked: môi trường chưa có `flutter` trong PATH).
- [ ] Chạy test (blocked: môi trường chưa có `flutter` trong PATH).
- [x] Ghi nhận hạn chế còn lại vào `memory/project-log.md`.
