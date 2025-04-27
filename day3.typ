#import "@preview/algo:0.3.6": algo, i, d, comment, code

#import "preamble.typ": *

#context bib_state.get()

= Fast Marching Algorithm

Bài toán lan truyền mặt biên (_Interface Propagation_) là một bài toán gắn liền với thực tế. Trong đó, sóng nước hay những đám cháy đều có thể diễn giải được bằng bài toán lan truyền mặt biên. Trong đó, Narrow Band Level set và Fast Marching là những phương pháp thường được dùng để giải những bài toán này.

Fast Marching algorithm (tạm dịch là Thuật toán Hành tiến nhanh) là một thuật toán tìm đường nhanh, được James A. Sethian sáng tạo vào những năm 1990. 

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

Phương trình Eikonal là một dạng tĩnh của phương trình Hamilton-Jacobi. Phương trình Hamilton-Jacobi là một phương trình vi phân riêng rất quan trọng trong cơ học lý thuyết và toán lý. 

Phương trình này mô phỏng việc một dòng chảy hoạt động trong một không gian 2 chiều hoặc 3 chiều hữu hạn.

Xét trường hợp đơn giản là khi $f(x, y) = 1$ thì phương trình này trở thành phương trình khoảng cách Euclid, giúp xác định đường đi ngắn nhất từ một tập hợp điểm cho trước.

Ta đã biết hàm số $u(x, y) = (x^2 + y^2)^(1/2) - 1$ ứng với phương trình khoảng cách của đường tròn có thể giải được phương trình Eikonal. Đương nhiên, việc đặt $F(x) = 1$ và cho 0 là điều kiện biên khiến cho bài toán trở thành bài toán tính khoảng cách tới đường cong ban đầu $Gamma$.

Ngược lại, bây giờ hãy cho rằng dữ liệu biên được lấy từ 1 đường cong không lồi, và ta cần tìm khoảng cách từ bất kỳ điểm nào trong miền giá trị cho đến đường cong này.

Cách 1: tại mỗi điểm trên đường cong, ta đặt một "phân tử", và di chuyển chúng ra khỏi đường cong theo một hướng chuẩn, với tốc độ đơn vị. Tại bất kỳ thời điểm C nào, vị trí của tất cả phần tử này trả về tập hợp tất cả các điểm, có khoảng cách với đường cong ban đầu bằng C.

Cách thứ 2 là vẽ lại tất cả các điểm, nhưng ở một khoảng cách nhất định so với đường gốc. Cách này áp dụng nguyên lý Huygens. 
Nguyên lý Huygens là một phương pháp hình học để tìm mặt sóng của một sóng lan truyền tại một thời điểm sau, nếu biết mặt sóng tại một thời điểm trước đó. Kết quả của phần tìm mặt sóng này là một "wavefront", tức là một đường cong bất kỳ thể hiện tập hợp vị trí tất cả các điểm biên tại thời điểm $t$. #cite(<sethian1998fastmarching>)

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

Độ phức tạp của Fast Marching là $O(N log N)$, ứng dụng heap.
Có nhiều cách để lưu trữ các điểm, nhưng trong trường hợp này, ta lưu trữ giá trị `Trial` theo 1 cấu trúc nhất định. Khi 1 điểm được chọn, các điểm liền kề được cập nhật, và giá trị $u$ của chúng có thể thay đổi.
Vì vậy, một phần nhỏ trong số các điểm phải được sắp xếp lại để có được thứ tự các điểm như ý muốn. Điều này liên tưởng đến cấu trúc dữ liệu heap. Cụ thể, ta xây dựng min-heap, là một cây nhị phân đầy đủ, với tính chất là giá trị tại tất cả các nút phải bé hơn hoặc bằng giá trị của tất cả các nút con. Trong thực tế, ta xây dựng heap dưới dạng 1 mảng, với 1 nút tại index `k`, và các nút con ở index `2k` và `2k + 1`. Từ đây, ta rút ra rằng nút cha của bất kỳ nút nào nằm tại index `k / 2`, và phần tử nhỏ nhất nằm tại `k = 1` của mảng. Truy xuất nút con, nút cha chỉ là thao tác trên mảng với độ phức tạp $O(1)$.

Ta gọi:
- `UpHeap` (Vun đống từ dưới lên): Khi thêm một phần tử mới vào Heap, phần tử này sẽ được đẩy lên vị trí thích hợp để duy trì tính chất của Heap.
- `DownHeap` (Vun đống từ trên xuống): Khi loại bỏ nút gốc, phần tử cuối cùng của Heap được đưa lên gốc và tiến hành điều chỉnh từ gốc xuống để duy trì tính chất của Heap. #cite(<rdsicUpheapDownheap>)

Các giá trị của $u$ được lưu giữ cùng với các chỉ mục thể hiện vị trí trên không gian lưới. Thuật toán sẽ hoạt động như sau: Tìm phần tử nhỏ nhất trong `NarrowBand`. Gọi thao tác này là `FindSmallest`, nó xoá bỏ gốc của cây, rồi thực hiện `DownHeap` để thoả mãn cấu trúc heap được yêu cầu.
Tìm các điểm tiếp theo có trạng thái "FarAway", có bao gồm loại trừ các điểm đã đi qua (`Alive`), đánh dấu các điểm đó, rồi thực hiện thao tác `Insert`, tức thêm điểm mới vào heap. Kích cỡ của heap được tăng 1, phần tử mới được đặt ở cuối heap, rồi thực hiện `UpHeap` để sắp xếp lại.

Nếu có điểm nào trong heap phát hiện thay đổi giá trị $u$ thì thực hiện lại `UpHeap` để sắp xếp lại cho phù hợp.

Heap là cây nhị phân đầy đủ, luôn đảm bảo cân bằng, nên `UpHeap` và `DownHeap` luôn có độ phức tạp là $O(log N)$. Ứng với N phần tử, độ phức tạp của cả quá trình tăng lên $O(N log N)$. Đối với `NarrowBand`, nếu có 1 con trỏ đến phần tử tương ứng từ cấu trúc lưới đến heap thì độ phức tạp có thể giảm xuống $O(1)$. Nếu không, trường hợp tệ nhất là độ phức tạp tăng lên $O(N)$. 

Kết hợp lại, trên một lưới gồm $N$ điểm, độ phức tạp của Fast Marching là $O(N log N)$. Trên không gian ba chiều, mỗi chiều là M điểm, độ phức tạp của Fast Marching được giảm từ $O(N^4)$ xuống $O(N^3 log N)$. #cite(<alblas2018fastmarching>)


== Ứng dụng trong Phân tách mạch máu

Để thực hành Fast Marching để phân tách mạch máu, một bức ảnh mạch máu được sử dụng:

#figure(
  image("/images/blood-vessel.png", width: 80%),
  caption: [
      Mạch máu ban đầu
  ],
)

Hàm tốc độ lan truyền được dựa vào màu sắc của điểm ảnh. Điểm ảnh càng tối thì tốc độ càng cao, có nghĩa là tốc độ lan truyền trên các mạch máu sẽ cao hơn tốc độ bên ngoài mạch máu. Hàm tốc độ là $F(i, j)$ có giá trị tối đa là $1$, giá trị tối thiểu là $0.1$, tạo thành minh hoạ như hình sau.

#figure(
  image("/images/blood-speed-func.png", width: 80%),
  caption: [
      Đồ thị hàm tốc độ 
  ],
)
Ta có thể thấy rõ rằng những điểm thuộc về mạch máu có màu vàng hoặc xanh lục, ứng với tốc độ từ 0.6 trở lên, nghĩa là nó lan truyền đến rất nhanh. Ngược lại, các vùng còn lại mang màu xanh lục, nghĩa là tốc độ chậm.

Khi đã có được hàm tốc độ, thuật toán Hành tiến nhanh được thực thi.

#figure(
  image("/images/fm-imple.png", width: 80%),
  caption: [
     Đường đi của thuật toán từ xuất phát điểm bên trái - trên cùng
  ],
)
Từ bản đồ đường đi, có thể thấy thuật toán cơ bản đi dần đều từ phía trên cùng bên trái, đến phía dưới cùng bên phải. Tuy nhiên, các mạch máu vẫn mang màu xanh lục đậm, nghĩa là các mạch máu đã được thuật toán bao phủ nhanh chóng, trước khi bao phủ những vùng khác.

Bằng bản đồ `T` đã có, ta có thể xác định con đường ngắn nhất từ điểm khởi đầu cho đến điểm kết thúc. Con đường này được tìm thấy bằng Gradient Descent trong không gian liên tục. Đương nhiên, do tốc độ bên trong mạch máu nhanh hơn các điểm còn lại, con đường ngắn nhất có đi trên mạch máu.

#figure(
  image("/images/shortest-path.png", width: 80%),
  caption: [
     Đường đi ngắn nhất thuật toán tìm được
  ],
)
=== Thực nghiệm trên 3D Slicer

#figure(
  image("/images/aorta.png", width: 80%),
  caption: [
     Phân tích động mạch chủ trong ứng dụng 3D Slicer
  ],
)

Các bước thực hiện trong ứng dụng như sau:
+ Chọn dataset mẫu, ở đây là `CTCardio`.
+ Chọn công cụ `Segment Editor` từ thanh tác vụ phía trên màn hình. 
+ Bật công cụ `Paint`, phía bên trái màn hình. Có thể chọn màu sắc nếu cần.
+ Lựa chọn độ sâu tương ứng của lát cắt cho đến khi nhìn thấy bộ phận tương ứng
+ Đánh dấu một số vị trí thuộc bộ phận động mạch chủ. Không có quy tắc nhất định trong việc đánh dấu. Càng nhiều dấu, động mạch chủ càng xuất hiện chính xác. 
Có thể lặp lại bước 4 và 5 cho đến khi thấy hợp lý.
+ Bật công cụ `Fast Marching`
+ Không thay đổi thông số nào, bấm `Initialize`.
+ Khi đã hoàn thành, chỉnh `Segment Volume` về khoảng $1$-$2%$.
+ Chọn `Show 3D` để mô hình 3D xuất hiện.

Fast Marching sẽ lấy gần hết tất cả chi tiết có trong mô hình. Tuy nhiên, ta chỉ cần trích xuất động mạch chủ, nghĩa là một thể tích rất nhỏ trong tổng thể tích của toàn bộ mô hình. Lựa chọn `Segment Volume` chỉ $1$-$2%$, tức là chỉ lấy dưới $2%$ thể tích tính từ điểm khởi đầu của thuật toán Fast Marching (ở đây là bên trong động mạch chủ đã chọn sẵn bằng Paint).