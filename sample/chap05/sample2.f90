program sample
  implicit none

  ! 宣言と同時に初期化
  integer :: a(5) = (/1, 2, 4, 8, 16/)

  ! 定数配列
  integer, parameter :: b(3) = (/-1, 0, 1/)

  ! "(/" と "/)" で囲えばその場で配列を作ることが出来る
  write(*,*) (/1, 2, 3/)

  write(*,*) a

  write(*,*) b

  stop
end program sample
