#import "@preview/algo:0.3.6": algo, i, d, comment, code

= Fast Marching Algorithm

Bài toán lan truyền mặt biên (_Interface Propagation_) là một bài toán gắn liền với thực tế. Trong đó, sóng nước hay những đám cháy đều có thể diễn giải được bằng bài toán lan truyền mặt biên. Trong đó, Narrow Band Level set và Fast Marching là những phương pháp thường được dùng để giải những bài toán này.

Fast Marching algorithm (tạm dịch là Thuật toán Hành tiến nhanh) là một thuật toán tìm đường nhanh, được James A. Sethian sáng tạo vào những năm 1990. 

// Đây là phương pháp số học để giải phương trình Eikonal phi tuyến bằng phương pháp xấp xỉ. Phương trình Eikonal có dạng:

// $
//   | nabla u(x) | = F(x) "in" Omega 
// $
// với $ F(x) > 0 $.


== Phương trình Eikonal

Phương trình Eikonal là một phương trình đạo hàm riêng phi tuyến tính, có dạng:

$
  |nabla u| = f (x, y)
$

trong đó:
- $u(x, y)$ là hàm ẩn cần tìm, thường biểu diễn khoảng cách hoặc thời gian di chuyển từ một điểm xuất phát
- $nabla u$ là gradient của $u$, tức là đạo hàm bậc nhất theo các biến không gian. Đây là vector biểu diễn hướng và tốc độ thay đổi của $u(x, y)$.
$
  nabla u = (frac(partial u, partial x), frac(partial u, partial y))
$
- $|nabla u|$ là chuẩn (norm) của gradient, thể hiện độ lớn của tốc độ thay đổi của $u$ theo không gian.

$
  |nabla u| = sqrt( frac(partial u, partial x)^2 + frac(partial u, partial y)^2 )
$

- $f(x, y)$ là hàm số tốc độ của mỗi điểm trong không gian. Nếu $f(x, y) = 1$, phương trình trở thành phương trình Eikonal chuẩn, dùng để tính khoảng cách từ 1 điểm nguồn.

Phương trình Eikonal là một dạng tĩnh của phương trình Hamilton-Jacobi.

Phương trình này mô phỏng việc một dòng chảy hoạt động trong một không gian 2 chiều hoặc 3 chiều hữu hạn.

Xét trường hợp đơn giản là khi $f(x, y) = 1$ thì phương trình này trở thành phương trình khoảng cách Euclid, giúp xác định đường đi ngắn nhất từ một tập hợp điểm cho trước.

Ta đã biết hàm số $u(x, y) = (x^2 + y^2)^(1/2) - 1$ ứng với phương trình khoảng cách của đường tròn có thể giải được phương trình Eikonal. Đương nhiên, việc đặt $F(x) = 1$ và cho 0 là điều kiện biên khiến cho bài toán trở thành bài toán tính khoảng cách tới đường cong ban đầu $Gamma$.

Ngược lại, bây giờ hãy cho rằng dữ liệu biên được lấy từ 1 đường cong không lồi, và ta cần tìm khoảng cách từ bất kỳ điểm nào trong miền giá trị cho đến đường cong này.

Cách 1: tại mỗi điểm trên đường cong, ta đặt một "phân tử", và di chuyển chúng ra khỏi đường cong theo một hướng chuẩn, với tốc độ đơn vị. Tại bất kỳ thời điểm C nào, vị trí của tất cả phần tử này trả về tập hợp tất cả các điểm, có khoảng cách với đường cong ban đầu bằng C.

Cách thứ 2 là vẽ lại tất cả các điểm, nhưng ở một khoảng cách nhất định so với đường gốc. Cách này áp dụng nguyên lý Huygens. 
Nguyên lý Huygens là một phương pháp hình học để tìm mặt sóng của một sóng lan truyền tại một thời điểm sau, nếu biết mặt sóng tại một thời điểm trước đó. Kết quả của phần tìm mặt sóng này là một "wavefront", tức là một đường cong bất kỳ thể hiện tập hợp vị trí tất cả các điểm biên tại thời điểm $t$.

Mặt ngoài (envelope) của đường sóng tạo thành một tập hợp cố định là những "điểm đến đầu tiên", tức là một đường sóng lan truyền tới đâu, thì điểm đó là cố định. Mặt ngoài của đường sóng khi được kết nối lại sẽ tạo thành một đường cong; và đường cong này không khả vi, cũng như ta không thể tính được gradient $nabla u$. Vì cần tìm khoảng cách ngắn nhất đến các điểm "envelope", ta chọn cách làm thứ 2.

Hãy xem đường sóng này như rìa của vũng nước: bất kỳ điểm nào nằm bên trong đường sóng này sẽ luôn ngập nước. Tương tự với một đám lửa, bất kỳ điểm nào, một khi đã cháy thì sẽ không bao giờ tắt. Điều này giúp cách làm trên thoả mãn điều kiện entropy: đảm bảo mọi phương pháp phải phù hợp về mặt vật lý, và thoả mãn tính đơn ánh.

Để làm được điều đó, ta lại cần cộng thêm một hạng tử "làm trơn", nhằm gọt bỏ những điểm nhọn, đảm bảo kết quả là một vùng trơn, như vậy mới có thể giữ cho phương trình Eikonal luôn khả vi. Hơn nữa, trong thực tế, không có một đường sóng nào có "góc nhọn", vậy nên cách làm này càng đảm bảo tính thực tế.

$
  | nabla u(x) | = F(x) + epsilon nabla^2 u |
$

Mục tiêu là ta cần xây dựng phương pháp số học để tự động trích xuất được giá trị hạng tử này.


// TODO Giải thích cho bằng được phương trình Eikonal : cũng cũng tạm

== Xấp xỉ phương trình Eikonal

Ta có "upwind scheme" của Godunov, hay dạng rời rạc của phương trình Eikonal:

$
  mat(
    max(D_(i j k)^(-x)u, -D_(i j k)^(+x)u, 0)^2 +;
    max(D_(i j k)^(-y)u, -D_(i j k)^(+y)u, 0)^2 +;
    max(D_(i j k)^(-z)u, -D_(i j k)^(+z)u, 0)^2
  ) = F_(i j k)
$

với:
- $D^-$ và $D^+$ là các toán tử sai phân tiến và lùi
- $F_(i j k)$ là độ chậm tại điểm lưới $(i, j, j)$, tức là nghịch đảo tốc độ lan truyền tại điểm đó.

Công thức này mô tả cách ước lượng giá trị của hàm $u$ tại một điểm lưới dựa trên các giá trị lân cận.

Một cách giải thông dụng là sử dụng phương pháp lặp, như đề xuất của Rouy và Tourin.
Ý tưởng cập nhật giá trị $u$ từng bước dựa trên lược đồ stencil gồm 6 điểm lân cận, liên tục cho đến khi phương trình được thoả mãn.

#algo(
  title: "QuadraticSolve"
)[
  for $"iter" <- 1$ to $n$:#i\
    for $i, j, k <- 1$ to Mesh:#i\
      Solve Quadratic for $u_(i j k)^("iter" + 1)$, given \
      $u_(i-1, j, k)^("iter")$, $u_(i+1, j, k)^("iter")$,
      $u_(i, j-1, k)^("iter")$, $u_(i, j+1, k)^("iter")$,
      $u_(i, j, k-1)^("iter")$, $u_(i, j, k+1)^("iter")$ #d\ 
    end for  #d\ 
  end for \
]


== Giải thuật
Ý tưởng chính của Fast Marching là xây dựng nghiệm theo cách có trật tự, đi từ những điểm có giá trị nhỏ nhất rồi mở rộng dần ra.

Nó sử dụng một chiến lược gọi là upwind difference, nghĩa là chỉ lấy thông tin từ những điểm đã biết để tính toán điểm tiếp theo. Điều này đảm bảo rằng giá trị tại mỗi điểm luôn dựa trên những giá trị đã được xác định trước đó, phù hợp với điều kiện entropy.

Fast Marching không sử dụng phương pháp lặp đã nêu ở phần trước, mà sử dụng lược độ cập nhật theo thứ tự chính xác (causal ordering) để tìm nghiệm.

Quy trình có thể được mô tả như sau:
1. Bắt đầu từ điểm gốc: Giả sử ta đang tính khoảng cách ngắn nhất từ 1 điểm xuất phát
2. Mở rộng tập nghiệm: Giống như một làn sóng lan ra xung quanh, thuật toán cập nhật các điểm gần đó theo thứ tự từ nhỏ đến lớn. Các điểm này có dạng một dải hẹp (narrow band), nằm liền kề với các điểm biên của làn sóng.
3. Cập nhật điểm kế tiếp: Mỗi lần mở rộng, thuật toán chọn điểm có giá trị nhỏ nhất trong dải hẹp, và đưa điểm đó vào bên trong làn sóng. Nói cách khác, trong bước kế tiếp, làn sóng sẽ đi qua điểm này.
Quá trình này sẽ được lặp lại.

#algo(
  title: "FastMarching"
)[
  mark all initial condition points as _Alive_ \
  mark all points one grid point away as _Close_ \
  mark all other points as _Far_ \
  \
  while Close is not empty:#i\
    _Trial_ $<-$ point in close with the smallest value of $u$ #d\
  \
  for each neighbor $N$ of _Trial_:#i\
    if $N$ is not _Alive_:#i\
      if $N$ is in _Far_:#i\
        Remove $N$ from _Far_\
        Add $N$ to _Close_\
      #d
    #d
  end for#d \

  Recompute $u$ for all _Close_ neighbor of _Trial_ using piecewise quadratic equation\
  Move _Trial_ from _Close_ to _Alive_
] 

Thuật toán này hoạt động tốt, vì các điểm xung quanh sẽ không tồn tại giá trị nào thấp hơn nhưng điểm đã cho. Ta có thể hiểu quá trình này như một dòng nước đang chảy ở một vùng gồ ghề, trong đó, ở vùng kế cận với dòng nước, điểm nào có cao độ thấp hơn, nước sẽ chảy đến đó trước.

