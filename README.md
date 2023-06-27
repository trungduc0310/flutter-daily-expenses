# my_todo_app

A Todo project manage Manage daily expenses.

## Design App
open with draw.io:
design/design-app-to-do.drawio

#Note
Đồng bộ firestore:
    -
Chức năng ứng tiền theo ngày:
    - Yêu cầu: Ứng tiền hàng ngày cho mọi người, cuối tuần hoặc 1 khoảng thời gian nhất định tổng hợp lại số tiền của từng người ->  đi thu tiền
    - Home: 
        + danh sách mọi người -> số tiền tương ứng người đó (chỉ hiển thị những người vẫn còn khoản nợ)
        + tổng số tiền nợ
    - Thêm khoản tiền:
        + chọn ngày 
        + tên khoản tiền
        + số tiền
        + danh sách người tham gia
        + chọn kiểu chia tiền: chia đều, tùy chọn(người ít, người nhiều)
