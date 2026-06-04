# Trip Memories - Decision Records

## ADR-001 - Dùng MapTiler cho bản đồ và tìm kiếm
- Ngày: 2026-06-04.
- Trạng thái: accepted.
- Lý do: người dùng chọn MapTiler cho giai đoạn 1.
- Hệ quả: dùng `flutter_map` để render tile, MapTiler Geocoding để tìm kiếm địa điểm.
- Lưu ý: API key phải truyền qua runtime config, không hardcode vào repository.

## ADR-002 - Dùng Riverpod cho state management
- Ngày: 2026-06-04.
- Trạng thái: accepted.
- Lý do: ít boilerplate, dễ test, phù hợp app Flutter có nhiều luồng async.
- Hệ quả: repository, controller và state được expose qua providers.

## ADR-003 - Dùng sqflite cho local database
- Ngày: 2026-06-04.
- Trạng thái: accepted.
- Lý do: dữ liệu memory có cấu trúc rõ, cần CRUD ổn định và có thể migration.
- Hệ quả: quản lý schema version từ đầu, lưu danh sách ảnh dưới dạng JSON string.

## ADR-004 - Lưu ảnh trong app documents
- Ngày: 2026-06-04.
- Trạng thái: accepted.
- Lý do: ảnh cần tồn tại độc lập với picker cache và được quản lý bởi app.
- Hệ quả: khi xóa memory cần xóa cả file ảnh tương ứng nếu file nằm trong thư mục app quản lý.
