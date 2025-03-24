

= CT
== Khái niệm

Chụp cắt lớp vi tính, còn gọi là chụp CT (Computerized Tomography), là kỹ thuật kết hợp máy tính và tia X để tạo ra hình ảnh các cơ quan, xương và các mô của cơ thể theo lát cắt ngang, cho phép phóng 1 chùm tia X liên tục qua cơ thể. Đây là một kỹ thuật không xâm lấn.

Hình ảnh thu được sẽ được máy tính xử lý, tái tạo để cho ra cấu trúc bên trong. Độ phân giải (hay độ sắc nét) hình ảnh tuỳ thuộc vào thế hệ máy chụp là 4, 16, hay 64 lát cắt. Nếu máy chụp có số lát cát càng cao thì hình ảnh càng rõ nét. Tuỳ theo độ cản tia X, các tổn thương ở những bộ phận bên trong cơ thể được diễn tả bằng cách tăng hoặc giảm độ đậm.

Trong quá trình chụp CT, người bệnh được chỉ định nằm trên một chiếc máy, khi ấy máy dò và ống tia X sẽ xoay xung quanh, mỗi vòng quay sẽ cho ra một hình ảnh lát mỏng của cơ thể. Sau đó, những hình ảnh này được gửi đến máy tính, nơi chúng được kết hợp để tạo ra hình ảnh các lát cắt hoặc mặt cắt ngang của cơ thể. Quá trình này không mất nhiều thời gian và cũng không gây đau đớn cho người bệnh.

// https://www.vinmec.com/vie/bai-viet/chup-ct-va-mri-khac-nhau-nao-vi
// https://tamanhhospital.vn/chup-ct/
// 

== Lịch sử

#figure(
  image("/images/ct-evolution.png", width: 80%),
  caption: [
      Quá trình phát triển của máy chụp CT.
  ],
)
 
Năm 1917, Định lý Radon ra đời, đóng vai trò quan trọng trong việc phát triển thuật toán tái tạo ảnh của chụp CT sau này.

Giai đoạn sơ khai (1971 - 1985):
- 1971: Hệ thống chụp CT đầu tiên được phát minh, tập trung vào quét não (*Head CT*).
- 1974: Công nghệ mở rộng ra để chụp toàn bộ cơ thể (*Body CT*), đánh dấu bước tiến quan trọng trong chẩn đoán y khoa.
- 1975: Sự ra đời của máy CT thế hệ thứ ba (*3rd Generation CT*), giúp tăng tốc độ chụp ảnh.

Giai đoạn cải tiến công nghệ (1987 - 2000):
- 1987: Phát triển công nghệ *Solid State Detectors* (Bộ dò trạng thái rắn), giúp tăng cường độ nhạy và cải thiện chất lượng hình ảnh.
- 1990: Ứng dụng công nghệ *Slip Ring*, giúp chụp xoắn ốc (Helical CT), mở đường cho chụp ảnh 3D tốc độ cao.
- 1993: Công nghệ CT có khả năng chụp 4 hoặc 8 lát cắt (4/8-Slice CT), tăng đáng kể độ chi tiết của hình ảnh.
- 1995: Tốc độ quét giảm xuống còn 1.0 giây/lần chụp.

Giai đoạn phát triển mạnh mẽ (2000 - 2010):
- 2000: Cải tiến tốc độ quét còn 0.8 giây/lần, đồng thời áp dụng phương pháp giảm liều phóng xạ *AEC Dose Reduction*.
- 2002: Ra mắt CT 16 lát cắt (*16-Slice CT*), cải thiện đáng kể khả năng phân giải không gian.
- 2005: Tiếp tục giảm tốc độ quét xuống còn 0.5 giây/lần, giúp chụp nhanh hơn.
- 2007: CT 32/64 lát cắt (*32/64-Slice CT*) xuất hiện, hỗ trợ chẩn đoán chi tiết hơn, đặc biệt là trong tim mạch.
- 2008: Phát triển công nghệ *Spectral Imaging* và *ASiR* (Adaptive Statistical Iterative Reconstruction), giúp giảm nhiễu ảnh và tối ưu hóa chất lượng hình ảnh.

Giai đoạn hiện đại:
- 2010: Công nghệ CT có độ phân giải cao (Hi-Res CT), cung cấp hình ảnh sắc nét hơn.
- 2011: Giới thiệu *Veo Iterative Reconstruction*, một thuật toán tái tạo ảnh tiên tiến giúp giảm liều phóng xạ nhưng vẫn giữ được chất lượng hình ảnh cao.
- 2012: Xuất hiện công nghệ *Motion Correction*, giúp cải thiện hình ảnh của các bộ phận di chuyển như tim và phổi.

= MRI

== Khái niệm

Chụp cộng hưởng từ hay còn gọi là chụp MRI (Magnetic Resonance Imaging) là phương pháp sử dụng từ trường mạnh, sóng vô tuyến và máy tính để phác hoạ hình ảnh chi tiết bên trong cơ thể con người. Đây là một kỹ thuật không xâm lấn.  
Không giống như chụp X-quang và chụp cắt lớp vi tính (CT), MRI không sử dụng bức xạ ion hóa gây hại của tia X.

Máy MRI hoạt động bằng cách tạo ra một từ trường mạnh bên trong cơ thể. Một máy tính lấy các tín hiệu từ MRI để tạo ra hàng loạt ảnh, mỗi bức ảnh cho thấy một phần mỏng của cơ thể.

== Lịch sử


= Định lý Phép chiếu Lát cắt (Projection Slice Theorem)

Đây là một định lý quan trọng trong Xử lý ảnh y khoa và Tomography.

Cho $f(x, y)$ là ảnh 2 chiều.

Ta định nghĩa phép biến đổi Fourier 2 chiều của nó:

$
  F(u, v) = integral_(-infinity)^(infinity) integral_(-infinity)^(infinity) f(x, y) e^(-j 2 pi (u x + v y) ) dif x dif y
$

Giả sử ta lấy một phép chiếu theo hướng $theta$, tức là tích luỹ cường độ theo trục vuông góc với hướng đó:

$
  P_theta (r) = integral_(-infinity)^(infinity) f (r cos theta - s sin theta, r sin theta + s cos theta ) dif s
$

Đây là phép chiếu Radon, cho ta một ảnh 1D (1 chiều) biểu diễn cách ảnh gốc lan truyền theo hướng $theta$.

Định lý Phép chiếu Lát cắt khẳng định rằng biến đổi Fourier 1 chiều của phép chiếu $ P_theta (r) $ chính là một lắt cắt của biến đổi Fourier 2 chiều $F (u, v)$ dọc theo đường thẳng có góc $theta$ trong miền tần số:

$
  P_theta (k) = F (k cos theta, k sin theta)
$

= Kiến trúc chương trình Slicer 

Chương trình Slicer gồm 