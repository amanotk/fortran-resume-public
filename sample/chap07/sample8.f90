!!!!!!!!!!! 外部手続きの定義場所 (1) !!!!!!!!!!
function square_ext1(x) result(y)
  implicit none
  real(8) :: x
  real(8) :: y

  y = x**2

  return
end function square_ext1
!!!!!!!!!!!

! メインプログラム
program sample
  implicit none
  !
  ! 外部関数のinterface宣言
  ! (本当は後で学ぶモジュールを使うほうがスマート)
  !
  interface
     real(8) function square_ext1(x)
       real(8) :: x
     end function square_ext1
  end interface

  !
  ! 外部サブルーチンのinterface宣言
  !
  interface
     subroutine sub_ext()
     end subroutine sub_ext
  end interface


  ! 外部関数を呼び出すには実はこの書き方でも良いが，色々と問題が多いので非推奨
  real(8), external :: square_ext2


  ! 外部関数呼び出し
  write(*,*) square_ext1(2.0_8), square_ext2(4.0_8)

  ! 外部サブルーチン呼び出し
  call sub_ext()

  stop
end program sample

!!!!!!!!!!! 外部手続きの定義場所 (2) !!!!!!!!!!
function square_ext2(x) result(y)
  implicit none
  real(8) :: x
  real(8) :: y

  y = x**2

  return
end function square_ext2

subroutine sub_ext()
  implicit none

  write(*,*) 'sub_ext'

  return
end subroutine sub_ext
!!!!!!!!!!!
