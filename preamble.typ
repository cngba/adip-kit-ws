#import "/iclr2025.typ": iclr2025

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

#let bib_state = state("bib_state",
  bibliography("biblio.bib", title: auto))