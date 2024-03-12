module mod_vector
  implicit none
  private

  type :: vector2
    real(8) :: x, y
  endtype vector2

  interface operator(+)
    module procedure add2
  endinterface operator(+)

  interface operator(-)
    module procedure sub2
  endinterface operator(-)

  interface operator(*)
    module procedure cross2
  endinterface operator(*)

  interface assignment(=)
    module procedure assign2, assign2_array
  endinterface assignment(=)

  interface show
    module procedure show2
  endinterface show

  public :: vector2
  public :: show, operator(+), operator(-), operator(*), assignment(=)

contains

  !
  ! 2次元ベクトル用演算子
  !
  function add2(a, b) result(ret)
    implicit none
    type(vector2), intent(in) :: a, b
    type(vector2) :: ret

    ret % x = a % x + b % x
    ret % y = a % y + b % y
  endfunction add2

  function sub2(a, b) result(ret)
    implicit none
    type(vector2), intent(in) :: a, b
    type(vector2) :: ret

    ret % x = a % x - b % x
    ret % y = a % y - b % y
  endfunction sub2

  function cross2(a, b) result(ret)
    implicit none
    type(vector2), intent(in) :: a, b
    real(8) :: ret

    ret = a % x * b % y - a % y * b % x
  endfunction cross2

  subroutine assign2(a, b)
    implicit none
    type(vector2), intent(out) :: a
    real(8), intent(in) :: b

    a % x = b
    a % y = b
  endsubroutine assign2

  subroutine assign2_array(a, b)
    implicit none
    type(vector2), intent(out) :: a
    real(8), intent(in) :: b(2)

    a % x = b(1)
    a % y = b(2)
  endsubroutine assign2_array

  subroutine show2(v)
    implicit none
    type(vector2), intent(in) :: v

    write(*, '("vector2 : ", f10.4, ",", f10.4)') v % x, v % y
    return
  endsubroutine show2

endmodule mod_vector

program answer
  use mod_vector
  implicit none

  type(vector2) :: a, b, c

  write(*, fmt='(a)') '--- vector2 ---'

  a = (/1.0_8, 0.0_8/)
  b = 1.0_8
  c = a + b

  call show(a + b)
  call show(a - b)

  stop
endprogram answer
