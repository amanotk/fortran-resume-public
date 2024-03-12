! ベクトルモジュール
module mod_vector
  implicit none
  private

  ! 2次元のベクトル
  type :: vector2
    real(8) :: x, y
  endtype vector2

  ! + 演算子のオーバーロード
  interface operator(+)
    module procedure add2, add2_scalar1, add2_scalar2
  endinterface operator(+)

  ! - 演算子のオーバーロード
  interface operator(-)
    module procedure sub2
  endinterface operator(-)

  ! = 演算子のオーバーロード
  interface assignment(=)
    module procedure assign2
  endinterface assignment(=)

  ! 表示サブルーチンのオーバーロード
  interface show
    module procedure show2
  endinterface show

  ! 公開
  public :: vector2
  public :: show, operator(+), operator(-), assignment(=)

contains
  ! + 演算子の中身
  function add2(a, b) result(ret)
    implicit none
    type(vector2), intent(in) :: a, b
    type(vector2) :: ret

    ret % x = a % x + b % x
    ret % y = a % y + b % y
  endfunction add2

  ! + 演算子の中身: vector2 + scalar
  function add2_scalar1(a, b) result(ret)
    implicit none
    type(vector2), intent(in) :: a
    real(8), intent(in) :: b
    type(vector2) :: ret

    ret % x = a % x + b
    ret % y = a % y + b
  endfunction add2_scalar1

  ! + 演算子の中身: scalar + vector2
  function add2_scalar2(a, b) result(ret)
    implicit none
    real(8), intent(in) :: a
    type(vector2), intent(in) :: b
    type(vector2) :: ret

    ret % x = a + b % x
    ret % y = a + b % y
  endfunction add2_scalar2

  ! - 演算子の中身
  function sub2(a, b) result(ret)
    implicit none
    type(vector2), intent(in) :: a, b
    type(vector2) :: ret

    ret % x = a % x - b % x
    ret % y = a % y - b % y
  endfunction sub2

  ! = 演算子の中身
  subroutine assign2(a, b)
    implicit none
    type(vector2), intent(out) :: a ! intent(out) に注意
    real(8), intent(in) :: b ! intent(in)  に注意

    ! どちらも同じ値
    a % x = b
    a % y = b
  endsubroutine assign2

  ! 表示
  subroutine show2(v)
    implicit none
    type(vector2), intent(in) :: v

    write(*, '("vector2 : ", f10.4, ",", f10.4)') v % x, v % y
    return
  endsubroutine show2

endmodule mod_vector

! vectorモジュールを使うサンプル
program sample
  use mod_vector
  implicit none

  type(vector2) :: a, b, c, d

  a % x = 1.0_8
  a % y = 0.0_8

  call show(a + 1.0_8)  ! add2_scalar1の呼び出し
  call show(0.5_8 + a)  ! add2_scalar2の呼び出し

  ! 以下は単精度実数に対する演算が定義されていないのでエラー
  !call show(0.5 + a)

  ! 代入演算子を用いる
  b = 1.0_8

  call show(a)
  call show(b)

  c = a + b
  call show(c)

  d = a - b
  call show(d)

  stop
endprogram sample
