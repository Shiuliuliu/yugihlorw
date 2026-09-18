# SỔ TAY HƯỚNG DẪN CHỈNH SỬA TOÀN DIỆN DỰ ÁN YU-GI-OH WEB H5

Tài liệu này tổng hợp chi tiết vị trí các file và cách thức chỉnh sửa từng thành phần của game để bạn dễ dàng tra cứu và chỉnh sửa khi cần.

---

## 1. TỔNG QUAN CẤU TRÚC DỰ ÁN (BẢN BUNG KHÔNG MÃ HÓA - SỬA TRỰC TIẾP)

Dự án đã được **bung toàn bộ mã nguồn và dữ liệu thành các file độc lập**, không còn mã hóa hay đóng cục. Bạn có thể mở trực tiếp bất kỳ file nào bằng VS Code hoặc Notepad, sửa nội dung, bấm **Save (Ctrl + S)** và **F5 trang web** là game lập tức nhận thay đổi!

| Thành phần | Vị trí thư mục / File | Vai trò |
| :--- | :--- | :--- |
| **Mã nguồn Lua Client** | `web/src/*.lua` | **419 file Lua độc lập** (`ClientView.lua`, `CardList.lua`, `ShopScene.lua`, `BattleScene.lua`...). Mở sửa trực tiếp, Web Server tự động live-reload tức thì! |
| **Dữ liệu cấu hình Game** | `web/data/*.lua` | **133 bảng dữ liệu độc lập** (`monster.lua`, `card.lua`, `drop.lua`, `magic.lua`, `trap.lua`, `rare.lua`, `package.lua`...). Định dạng Lua table cực kỳ dễ đọc. |
| **Backend Server** | `yugioh_web_server.py` | Web server HTTP (cổng 8080), WebSocket PvP (cổng 9192), xử lý logic API, nạp tiền, bốc thẻ, nạp động mã nguồn `web/src/` và `web/data/`. |
| **Công cụ đồng bộ** | `sync_game.py` | Script 1-click đóng gói toàn bộ `web/src/` và `web/data/` thành `lua_src.json` và `data_dumps.json` (tự động chạy trong 0.4s). |
| **Database** | MySQL: Database `yugioh_game` | Lưu tài khoản (`accounts`), thẻ sở hữu, deck, lịch sử chat. |
| **Giao diện Web Client** | `web/` | Thư mục chứa toàn bộ mã nguồn frontend, assets hình ảnh, âm thanh, engine game. |
| **Engine Cocos2d & Bridge** | `web/js/engine.js`, `web/js/res.js`, `web/js/boot.js` | Kết nối Cocos2d-html5 với Lua WASM VM, nạp tài nguyên, xử lý canvas và shader. |
| **File font game** | `web/res/updater/HYB2GJM.TTF` | Font chữ TrueType của game (Be Vietnam Pro Bold). |
| **File đẩy Git** | `DAY_LEN_GITHUB.bat` | Script 1-click tự động commit và đẩy lên GitHub. |

---

## 2. HƯỚNG DẪN CHỈNH SỬA FONT CHỮ & HIỂN THỊ TEXT

### A. Thay đổi font chữ mới cho toàn game
1. **Thay file font:**
   - Đặt file font định dạng `.ttf` mới đè vào đường dẫn: `web/res/updater/HYB2GJM.TTF`.
2. **Khai báo trong CSS Web (`web/index.html`):**
   - Tìm thẻ `<style>` và khai báo `@font-face`:
     ```css
     @font-face {
         font-family: 'YuGiOhFont';
         src: url('res/updater/HYB2GJM.TTF') format('truetype');
         font-weight: normal;
         font-style: normal;
     }
     ```
3. **Cấu hình Engine Canvas (`web/vendor/cocos2d/core/labelttf/CCLabelTTFCanvasRenderCmd.js`):**
   - Trong hàm `proto._setFontStyle` (khoảng dòng 62), chuỗi CSS Canvas được gán:
     ```javascript
     this._fontStyleStr = fontStyle + " " + fontWeight + " " + deviceFontSize + "px '" + fn + "', 'YuGiOhFont', sans-serif";
     ```
4. **Cấu hình Font trong Lua (`web/src/ClientView.lua`):**
   - Mở trực tiếp file `web/src/ClientView.lua` (không cần giải mã gì cả).
   - Sửa dòng:
     ```lua
     var_0_0.TTF_FONT = "YuGiOhFont"
     ```
   - Bấm **Save (Ctrl + S)** -> F5 web là font có hiệu lực ngay!

---

## 3. HƯỚNG DẪN CHỈNH SỬA CỬA HÀNG (SHOP & GÓI BÀI)

### A. Chỉnh sửa Shop bán lẻ thẻ bài (Vàng / Kim cương)
- **Vị trí code:** File `yugioh_web_server.py`.
- **Hàm xử lý:** `_handle_buy_shop_card(self, data)` (tìm từ khóa `buy_shop_card`).
- **Thêm/Sửa giá bán của thẻ đặc biệt:**
  - Trong hàm `_handle_buy_shop_card`, kiểm tra ID thẻ. Ví dụ thẻ "Rồng xích dung nham" (ID `10304`) bán với giá 100,000 vàng:
    ```python
    if card_id == 10304:
        price_gold = 100000
    ```
- **Dữ liệu Shop trong Database:** Bảng `shop_cards` trong database `yugioh_game`.

### B. Chỉnh sửa Gói bài (Packs) & Tỷ lệ quay gacha
- **Vị trí code:** File `yugioh_web_server.py`.
- **Hàm xử lý:** `_handle_buy_package(self, data)` (tìm từ khóa `buy_package`).
- **Chỉnh tỷ lệ quay ra phẩm chất (UR / SR / R / N / GR):**
  - Tìm đoạn tính `rand_val = random.random()` trong `_handle_buy_package`:
    ```python
    # Ví dụ chỉnh tỷ lệ:
    # GR: 0.0001 (0.01%)
    # UR: 0.02 (2%)
    # Còn lại: random SR, R, N
    ```
- **Chỉnh danh sách thẻ bài trong từng gói:**
  - Mở trực tiếp file `web/data/drop.lua`: mỗi gói bài có 3 drop ID (tương ứng quay x1, x10, x50). Sửa mảng `_pid` để thêm/bớt danh sách ID thẻ bài trong gói đó.
  - Mở trực tiếp file `web/data/package.lua`: chứa tên gói, icon, mô tả gói bài.
  - Lưu file -> F5 web là cập nhật ngay lập tức!

---

## 4. HƯỚNG DẪN THÊM & SỬA LÁ BÀI (CARDS)

### A. Thêm hình ảnh thẻ bài
- **Ảnh chữ nhật trung tâm lá bài:** Đặt file ảnh kích thước khoảng 400x580 px vào:
  `web/res/jpg/<ID_THẺ>.jpg` (ví dụ: `web/res/jpg/10304.jpg`).
- **Ảnh toàn lá bài (Icon nhỏ):** Đặt vào thư mục `web/res/thumb_monster/`, `web/res/thumb_magic/`, `web/res/thumb_trap/` hoặc các container `.lcres`.

### B. Chỉnh sửa chỉ số thẻ bài (ATK, DEF, Sao, Hệ, Phẩm chất)
- **Vị trí:** Thư mục `web/data/`. Mở sửa trực tiếp bằng VS Code hoặc Notepad:
  - Quái thú: File `web/data/monster.lua` và `web/data/card.lua`.
    - `_atk`: Điểm tấn công gốc.
    - `_def` hoặc `_hp`: Điểm phòng thủ gốc.
    - `_star`: Số sao (cấp độ).
    - `_quality`: Phẩm chất (1: N, 2: R, 3: SR, 4: UR, 5: GR).
    - `_nature`: Thuộc tính (Hệ: Ánh sáng, Bóng tối, Lửa, Nước...).
  - Phép: File `web/data/magic.lua`.
  - Bẫy: File `web/data/trap.lua`.
  - Extra/Hiếm: File `web/data/rare.lua`.
  - Bấm **Save** là server nhận diện tự động!

### C. Chỉnh sửa Tên & Mô tả hiệu ứng tiếng Việt của lá bài
- **Vị trí:** File `web/res/lan.lcres/extend.lan` (hoặc `extend_lan.txt` ở thư mục gốc).
- Mỗi lá bài trong `web/data/card.lua` có 2 mã ID chuỗi:
  - `_nameSid`: ID của chuỗi Tên lá bài.
  - `_descSid`: ID của chuỗi Mô tả hiệu ứng lá bài.
- Tìm dòng có ID tương ứng trong file `web/res/lan.lcres/extend.lan` để sửa nội dung văn bản tiếng Việt.

---

## 5. HƯỚNG DẪN QUẢN LÝ TÀI KHOẢN, VÀNG, KIM CƯƠNG (DATABASE)

### A. Kết nối Database
- **Host:** `127.0.0.1`
- **User:** `root`
- **Password:** *(để trống)*
- **Database Name:** `yugioh_game`
- Bạn có thể dùng **Navicat**, **DBeaver**, **HeidiSQL** hoặc **phpMyAdmin** để quản lý trực quan.

### B. Các bảng chính trong Database
- **Bảng `accounts`:**
  - `id`: Mã ID người chơi (User ID).
  - `username`: Tên đăng nhập.
  - `name`: Tên nhân vật hiển thị trong game.
  - `gold`: Số vàng hiện có.
  - `diamond`: Số kim cương hiện có.
  - `level`: Cấp độ nhân vật.
  - `vip_level`: Cấp VIP.
  - `cards`: JSON danh sách thẻ bài người chơi đang sở hữu kèm số lượng.
  - `deck`: JSON danh sách bộ bài đang sử dụng.

### C. Lệnh cộng tiền/thẻ nhanh bằng SQL
```sql
-- Cộng 1,000,000 Vàng và 50,000 Kim Cương cho tài khoản có ID = 1
UPDATE accounts SET gold = gold + 1000000, diamond = diamond + 50000 WHERE id = 1;

-- Đặt cấp VIP 10
UPDATE accounts SET vip_level = 10 WHERE id = 1;
```

---

## 6. HƯỚNG DẪN BẬT THÔNG BÁO & BẢO TRÌ GAME

### A. Hiển thị Popup thông báo bảo trì toàn server
- **Vị trí:** File `yugioh_web_server.py`.
- Trong `yugioh_web_server.py`, có cơ chế phát sóng broadcast WebSocket tới tất cả người chơi:
  ```python
  # Gửi thông báo tới toàn bộ người chơi đang online qua WebSocket:
  msg = json.dumps({
      "type": "chat",
      "channel": 1,
      "sender": "[HỆ THỐNG]",
      "content": "Game bảo trì, dự kiến mở lại vào ... tương lai!"
  })
  ```
- Hoặc kích hoạt cờ trả về lỗi bảo trì tại các API `/api/login` để chặn đăng nhập khi đang bảo trì hệ thống.

---

## 7. HƯỚNG DẪN CHỈNH SỬA GIAO DIỆN & LOGIC TRẬN ĐẤU (BATTLE)

- **Vị trí:** File `web/lua_src.json`.
- **Các module cốt lõi:**
  - `BattleScene`: Quản lý toàn bộ vòng đời trận đấu (bắt đầu, chia bài, chọn mục tiêu, kết thúc).
  - `BattleUi`: Giao diện bàn đấu, thanh máu (LP), hiển thị mộ bài, vùng bài loại trừ, nút Kết Thúc Lượt.
  - `CardSprite`: Hiển thị thực thể lá bài khi cầm trên tay hoặc đặt trên bàn đấu (hiệu ứng xoay 3D, phóng to khi chạm).
  - `FindScene` / `FindClashArea`: Giao diện vượt ải cốt truyện (PVE chapters).
  - `HeroCenterScene`: Giao diện chọn tướng / nhân vật chính.

---

## 8. QUY TRÌNH ÁP DỤNG THAY ĐỔI & TRÁNH LỖI CACHE TRÌNH DUYỆT

Khi sửa code file JS, HTML, CSS hoặc Lua, trình duyệt của người chơi có thể lưu cache cũ. Thực hiện theo quy trình chuẩn sau:

1. **Nâng Version Cache Buster:**
   - Trong `web/index.html`: sửa `?v=20260919v2` thành version mới (ví dụ: `?v=20260919v3`).
   - Trong `web/vendor/CCBoot.js`: sửa `?v=20260919v2` tương ứng.
   - Trong `web/js/boot.js`: sửa biến `ver` tương ứng.
2. **Khởi động lại Web Server:**
   - Tắt tiến trình `python yugioh_web_server.py` đang chạy và bật lại:
     ```powershell
     python yugioh_web_server.py
     ```
3. **Trên trình duyệt người chơi:**
   - Nhấn **Ctrl + Shift + R** hoặc **Ctrl + F5** để ép tải lại toàn bộ trang và xóa sạch cache cũ.

---

## 9. ĐỒNG BỘ LÊN GITHUB

Khi hoàn tất các chỉnh sửa, chạy file script tự động:
```powershell
.\DAY_LEN_GITHUB.bat
```
Hoặc dùng lệnh Git thủ công:
```powershell
& "C:\tools\git\cmd\git.exe" add .
& "C:\tools\git\cmd\git.exe" commit -m "Mô tả thay đổi vừa thực hiện"
& "C:\tools\git\cmd\git.exe" push origin main
```
