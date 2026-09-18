# TÀI LIỆU YÊU CẦU KỸ THUẬT & KIẾN TRÚC HỆ THỐNG
## CHUYỂN ĐỔI GAME YU-GI-OH (QUYẾT CHIẾN CHI THÀNH) TỪ OFFLINE SANG ONLINE
**Dự án:** Quyết Chiến Chi Thành / Yu-Gi-Oh Mobile (`com.tuoyin.jdzc.android.guopan`)  
**Mục tiêu:** Chuyển đổi toàn diện từ Client Offline sang Online thời gian thực kết nối Socket Server & Database MySQL động.  
**Ngày lập:** 11/09/2026  

---

## I. TỔNG QUAN DỰ ÁN & BỐI CẢNH

### 1. Hiện trạng Game
- Phiên bản Client: 1.0.7 trên nền tảng Cocos2d-x LuaJIT (Android APK chạy giả lập MuMu Player 12).
- Trước đây game đã được Việt hóa toàn bộ cơ sở dữ liệu thẻ bài (quái thú, phép thuật, bẫy, extra deck) với thuật ngữ Yu-Gi-Oh chuẩn quốc tế (Triệu hồi Link, Synchro, Xyz, Dung hợp).
- Game đang ở trạng thái chạy Offline giả lập thông qua tệp `jdzc.lua` và khóa `JDZC_OFFLINE_STATE_V1` trong tệp cấu hình `Cocos2dxPrefsFile.xml`, khiến dữ liệu game luôn bị ép cố định một giá trị tĩnh (Mock Offline Data).

### 2. Yêu cầu Nghiệp vụ Mới
Chuyển đổi hoàn toàn cơ chế hoạt động của game thành **Online**:
1. **Giao diện Đăng nhập (Login Form):** Khi mở game, client phải hiển thị cửa sổ nhập **Tài khoản** (`username`) và **Mật khẩu** (`password`).
2. **Chọn Máy chủ (Select Server):** Sau khi xác thực tài khoản thành công, client hiển thị màn hình chọn Server (`SelectRegionForm` / `RegionScene`) với danh sách Server lấy động từ Socket Server.
3. **Nạp Dữ liệu Động từ MySQL:** Khi người chơi bấm "Vào Game", máy chủ Socket Server truy vấn trực tiếp cơ sở dữ liệu MySQL (`yugioh_game`) và trả về các thông số động của chính tài khoản đó:
   - Thông tin nhân vật: Tên nhân vật (`character_name`), Cấp độ (`level`), VIP (`vip_level`), Khung đại diện (`avatar`, `avatar_frame`).
   - Tài nguyên: Vàng (`gold`), Kim cương / Gem (`gem`), Đá hư vô (`void_stone`), Thẻ tím (`purple_ticket`), Thẻ Lôi Nhã (`leya_ticket`).
   - Kho thẻ bài sở hữu: Bảng `user_cards` (số lượng từng lá bài theo `card_id` và số bản copy).
   - Bộ bài của người chơi: Bảng `user_decks` (danh sách lá bài trong bộ bài ở định dạng JSON).
   - Tuyệt đối không sử dụng giá trị tĩnh ép cứng offline; mỗi tài khoản khi đăng nhập sẽ hiển thị đúng dữ liệu riêng của tài khoản đó.

---

## II. THIẾT KẾ CƠ SỞ DỮ LIỆU MYSQL (`yugioh_game`)

Hệ quản trị CSDL: MySQL 8.0 / MariaDB (Localhost:3306, DB: `yugioh_game`).

### 1. Bảng Tài khoản (`accounts`)
Lưu trữ thông tin người dùng và tài nguyên:
- `id` (INT, PK, Auto Increment)
- `username` (VARCHAR(50), Unique)
- `password` (VARCHAR(255)) - hỗ trợ cả Plaintext và Hash SHA-256
- `character_name` (VARCHAR(100)) - Tên nhân vật hiển thị (ví dụ: Yugi Muto, Seto Kaiba, Joey Wheeler)
- `level` (INT, Default 1)
- `exp` (INT, Default 0)
- `vip_level` (INT, Default 0)
- `avatar_id` (INT, Default 1)
- `gold` (BIGINT, Default 100000) - Tài nguyên Vàng
- `gem` (INT, Default 1000) - Kim cương / Gem
- `void_stone` (INT, Default 100) - Đá hư vô
- `purple_ticket` (INT, Default 10) - Thẻ tím
- `leya_ticket` (INT, Default 10) - Thẻ Lôi Nhã
- `server_id` (INT, Default 1)
- `created_at`, `last_login` (TIMESTAMP)

### 2. Bảng Bài sở hữu của Người chơi (`user_cards`)
Quản lý danh sách các lá bài mỗi tài khoản sở hữu:
- `id` (INT, PK, Auto Increment)
- `account_id` (INT, FK -> accounts.id)
- `card_id` (INT) - ID lá bài (từ các bảng monster, spell, trap, extra)
- `count` (INT, Default 1) - Số lượng sở hữu (1 đến 3 lá)
- `created_at` (TIMESTAMP)

### 3. Bảng Bộ bài Người chơi (`user_decks`)
Lưu trữ các bộ bài chiến đấu của người chơi dưới dạng JSON mảng card_id:
- `id` (INT, PK, Auto Increment)
- `account_id` (INT, FK -> accounts.id)
- `deck_index` (INT, 1-5) - Vị trí bộ bài
- `deck_name` (VARCHAR(100)) - Tên bộ bài (ví dụ: "Deck Rồng Trắng", "Deck Rồng Đen")
- `main_cards` (JSON/TEXT) - Mảng ID bài chính (40 - 60 lá): `[1001, 1002, 1003, ...]`
- `extra_cards` (JSON/TEXT) - Mảng ID bài phụ (0 - 15 lá): `[4001, 4002, ...]`

### 4. Các Bảng Từ Điển Thẻ Bài
- `card_monsters` (2,296 lá): Quái thú thường, hiệu ứng, chỉ số Công/Thủ, sao, thuộc tính, tộc bài.
- `card_spells` (1,128 lá): Bài phép thường, trang bị, môi trường, liên tục, kích hoạt nhanh, nghi thức.
- `card_traps` (576 lá): Bài bẫy thường, liên tục, phản đòn (Counter Trap).
- `card_extra` (721 lá): Quái thú Dung hợp (Fusion), Xyz, Synchro, Link.

---

## III. THIẾT KẾ MÁY CHỦ SOCKET TCP (PYTHON ASYNC SERVER)

### 1. Giao thức Mạng & Đóng gói Gói tin (Framing)
- **Cổng kết nối:** TCP Port `9191` (lắng nghe trên `0.0.0.0:9191`).
- **Framing:** Game sử dụng giao thức chuẩn Google Protobuf qua TCP:
  - Header: 4-byte Big-Endian biểu diễn độ dài payload (hoặc 2-byte BE tùy loại gói trong Socket_pb).
  - Body: Gói tin protobuf đã serialize (`SglReqMsg` từ client và `SglRespMsg` từ server).
- **Cấu trúc tin nhắn Protobuf:**
  - `SglReqMsg`: Chứa trường `type` (`ProtoMsgType` enum) và tập trường mở rộng `Extensions` tương ứng với từng module tính năng.
  - `SglRespMsg`: Chứa trường `type`, `status` (0: OK, 1: Error), `error_code`, và trường dữ liệu mở rộng phản hồi.

### 2. Các Mã Thông Điệp Cốt Lõi (`ProtoMsgType`)
1. `PB_TYPE_HEART_BEAT` (Mã 1000):
   - Client gửi định kỳ để duy trì kết nối mạng. Server phản hồi trạng thái OK kèm timestamp để đồng bộ thời gian.
2. `PB_TYPE_REGION_LIST` (Mã 1005):
   - Yêu cầu lấy danh sách Server.
   - Server phản hồi `region_list_resp` chứa danh sách server (ID, tên, IP, Port, trạng thái Mượt / Mới / Đề xuất) và thông tin `last_login` của tài khoản trên từng server.
3. `PB_TYPE_AUTHENTICATION` / `PB_TYPE_USER_LOGIN` (Mã 1001 / 1003):
   - Client gửi thông tin tài khoản: `username`, `password`, `device_info`.
   - Server truy vấn MySQL bảng `accounts`.
   - Nếu mật khẩu đúng: Trả về trạng thái thành công, cấp Session Token hoặc User ID.
   - Nếu sai: Trả về mã lỗi để client hiển thị thông báo.
4. `PB_TYPE_USER_LOGIN` (Vào Game Server):
   - Client gửi yêu cầu vào server đã chọn kèm User ID.
   - Server nạp toàn bộ dữ liệu người chơi từ MySQL (`accounts`, `user_cards`, `user_decks`) và đóng gói vào `UserInfo` / `FullUserInfo` trả về cho Client.
5. `PB_TYPE_CARDBOX_INFO` (Kho bài sở hữu):
   - Trả về danh sách toàn bộ thẻ bài trong `user_cards` của người chơi để hiển thị trong Rương Bài / Xếp Bài.
6. `PB_TYPE_TROOP_RELOAD` (Nạp Bộ bài):
   - Trả về các bộ bài từ bảng `user_decks`.

---

## IV. CẢI TIẾN PHÍA CLIENT (ANDROID APK & LUA HOOKS)

### 1. Cơ chế Tải Script của Game (Reverse Engineering Insights)
- Tệp mã nguồn game được đóng gói dưới định dạng `.lcsrc` mã hóa bằng thuật toán XOR/Rotate tuần hoàn với header `LCLUA\x00` và khóa 4-byte Little-Endian.
- Thư viện C++ `libyugioh_lua.so` khi khởi động tự động gọi `require 'src/jdzc.lua'`.
- Trình nạp `cocos2dx_lua_loader` ưu tiên tìm kiếm tệp tin tại thư mục có thể ghi `/data/data/com.tuoyin.jdzc.android.guopan/files/1.0.7/src/` trước khi tìm trong file nén APK gốc.
- Điều này cho phép nạp script tùy biến bằng mã Lua trực tiếp mà không cần sửa đổi file binary `libyugioh_lua.so`.

### 2. Giao diện Đăng nhập (Login Form UI)
- Tạo mới Dialog đăng nhập trước hoặc ngay trên `RegionScene`:
  - Ô nhập tài khoản (`ccui.EditBox`).
  - Ô nhập mật khẩu (`ccui.EditBox` kiểu password).
  - Nút "Đăng Nhập" (gửi lệnh xác thực tới Socket Server).
  - Nút "Đăng Ký" (hỗ trợ tạo tài khoản mới ngay trên client).
  - Lưu lại tên tài khoản đã đăng nhập gần nhất vào `UserDefault` để tiện đăng nhập lại lần sau.

### 3. Màn hình Chọn Server (Select Region UI)
- Sau khi đăng nhập thành công, chuyển sang `RegionScene`.
- Client kích hoạt `ClientData.reconnectRegionServer()`.
- Nhận danh sách Server động từ Python Socket Server (ví dụ: "S1 - Quyết Chiến Chi Thành", "S2 - Đấu Trường Hải Mã").
- Hiển thị Server đề xuất và nút "Vào Game".

### 4. Chuyển Đổi Dữ Liệu Động
- Gỡ bỏ hoàn toàn việc gán đè dữ liệu tĩnh từ `JDZC_OFFLINE_STATE_V1`.
- Kết nối trực tiếp đến IP máy chủ máy tính chủ: `10.0.2.2:9191` (Loopback nội bộ giữa giả lập MuMu và Windows host) hoặc `192.168.1.4:9191`.

---

## V. KẾ HOẠCH KIỂM THỬ VÀ XÁC MINH (VERIFICATION PLAN)

1. **Kiểm tra Máy chủ Socket độc lập:**
   - Sử dụng script kiểm thử `test_socket_client.py` gửi các gói Protobuf: Heartbeat, Region List, Authentication, User Login.
   - Xác minh phản hồi đúng chuẩn Protobuf và truy vấn MySQL chính xác.
2. **Kiểm tra Đăng nhập trên Game:**
   - Mở game trên MuMu Player 12.
   - Nhập tài khoản `admin` / mật khẩu `admin123`:
     - Tên nhân vật hiển thị: Yugi Muto.
     - Vàng: 999,999,999; Gem: 999,999.
     - Rương bài chứa đủ bộ sưu tập bài UR/SR.
   - Đổi sang tài khoản `kaiba` / mật khẩu `kaiba123`:
     - Tên nhân vật hiển thị: Seto Kaiba.
     - Dữ liệu vàng, gem và kho bài tự động chuyển đổi sang bộ bài Rồng Trắng Mắt Xanh.
   - Kiểm tra đăng nhập sai mật khẩu: Client hiển thị thông báo từ chối truy cập.

---
*Tài liệu được tổng hợp tự động phục vụ tích hợp NotebookLM và triển khai thực thi.*
