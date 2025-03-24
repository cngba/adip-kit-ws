= Fast Marching Algorithm

Bài toán lan truyền mặt biên (_Interface Propagation_) là một bài toán gắn liền với thực tế. Trong đó, sóng nước hay những đám cháy đều có thể diễn giải được bằng bài toán lan truyền mặt biên. Trong đó, Narrow Band Level set và Fast Marching là những phương pháp thường được dùng để giải những bài toán này.

Fast Marching algorithm (tạm dịch là Thuật toán Hành tiến nhanh) là một thuật toán tìm đường nhanh, được James A. Sethian sáng tạo vào những năm 1990. 

// Đây là phương pháp số học để giải phương trình Eikonal phi tuyến bằng phương pháp xấp xỉ. Phương trình Eikonal có dạng:

// $
//   | nabla u(x) | = F(x) "in" Omega 
// $
// với $ F(x) > 0 $.


== Phương trình Eikonal

Phương trình Eikonal là một phương trình đạo hàm riêng phi tuyến, có dạng:

$
  | nabla u | = f (x, y)
$

Xét trường hợp đơn giản là khi $f(x, y) = 1$ thì phương trình này trở thành phương trình khoảng cách Euclid, giúp xác định đường đi ngắn nhất từ một tập hợp điểm cho trước.

Phương trình Eikonal là một dạng tĩnh của phương trình Hamilton-Jacobi.

Phương trình này mô phỏng việc một dòng chảy hoạt động trong một không gian 2 chiều hoặc 3 chiều hữu hạn.

Boundary Value Formulation (Bài toán Giá trị Biên) là cách mô hình hoá chuyển động của mặt biên bằng cách đặt điều kiện biên tại tập hợp các điểm được xác định trước:

$
  | nabla T | F = 1
$

trong đó:
- $T$ là hàm thời gian đến
- $F$ là hàm tốc độ lan truyền của mặt biên

$T$ là một hàm số trong không gian $RR^3$, dành cho mặt p
Với một toạ độ $(x, y)$, T trả về thời gian mà mặt biên lan truyền đến toạ độ đã cho.

// TODO Giải thích cho bằng được phương trình Eikonal 


== Giải thuật
Thuật toán này 

// TODO Viết giải thuật


ả