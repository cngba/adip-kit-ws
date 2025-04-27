#import "/preamble.typ": *

#show: iclr2025.with(
  title: [Báo cáo: Workshop Xử lý ảnh y khoa],
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

#bib_state.update(none)

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