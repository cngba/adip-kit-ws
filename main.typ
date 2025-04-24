#import "/iclr2025.typ": iclr2025


// https://www.hurix.com/blogs/the-transformative-impact-of-ar-vr-in-healthcare/#:~:text=AR%20and%20VR%20technologies%20are,both%20patients%20and%20healthcare%20providers.

#let author-note = footnote[
  Use footnote for providing further information about author (webpage,
  Alternative address) --- *not* for acknowledging funding agencies.  Funding
  Acknowledgements go at the end of the paper.
]


#let authors = (
  (
    names: ([Nguyễn Huỳnh Hải Đăng], ),
    affilation: [ MSSV: 22127052 ],
    email: "nhhdang22@clc.fitus.edu.vn",
  ),
  (
    names: ([Lưu Nam Đạt],),
    affilation: [ MSSV: 22127062 ],
    email: "lndat22@clc.fitus.edu.vn",
  ),
  (
    names: ([Nguyễn Bá Công], ),
    affilation: [ MSSV: 22127046 ],
    email: "nbcong22@clc.fitus.edu.vn",
  ),
  (
    names: ([Đặng Trần Anh Khoa], ),
    affilation: [ MSSV: 22127024 ],
    email: "dtakhoa22@clc.fitus.edu.vn",
  ),

)
#show: iclr2025.with(
  title: [Workshop Report],
  authors: authors,
  keywords: (),
  abstract: [
    Workshop Xử lý ảnh y khoa đã được Trường Đại học Khoa học tự nhiên, ĐHQG-HCM và Viện Công nghệ Kyoto, Nhật Bản (Kyoto Institute of Technology) đồng tổ chức từ ngày 24-26/02/2025. Đây là báo cáo cho Workshop, do nhóm Orz thực hiện.  
  ],
  bibliography: bibliography("biblio.bib"),
  appendix: [
    #include "appendix.typ"
  ],
  accepted: true,
)

#show outline.entry.where(
  level: 1
): it => {
  v(12pt, weak: true)
  strong(it)
}
#outline(
    title: "Mục lục",
    indent: auto,
)

#let url(uri) = link(uri, raw(uri))

#include "day1.typ"
#include "day2.typ"
#include "day3.typ"