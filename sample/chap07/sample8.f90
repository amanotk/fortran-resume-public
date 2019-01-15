!!!!!!!!!!! 外部手続きの定義場所(1) !!!!!!!!!!
function square_ext1(x) result(y)
  implicit none
  real(8) :: x
  real(8) :: y

  y = x**2

  return
end function square_ext1
!!!!!!!!!!!

program sample
  implicit none
  !
  ! 外部関数を呼び出すために必要
  ! (本当は後で学ぶモジュールを使うほうがスマート)
  !
  interface
     real(8) function square_ext1(x)
       real(8) :: x
     end function square_ext1
  end interface

  ! 実はこれだけでも良いが，色々と問題が多いので非推奨
  real(8), external :: square_ext2

  write(*,*) square_ext1(2.0_8), square_ext2(4.0_8)

  stop
end program sample

!!!!!!!!!!! 外部手続きの定義場所(2) !!!!!!!!!!
function square_ext2(x) result(y)
  implicit none
  real(8) :: x
  real(8) :: y

  y = x**2

  return
end function square_ext2
!!!!!!!!!!!
