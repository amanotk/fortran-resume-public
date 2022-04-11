module mod_vector
  implicit none
  private

  type :: vector2
     real(8) :: x, y
  end type vector2

  interface operator (+)
     module procedure add2
  end interface operator (+)

  interface operator (-)
     module procedure sub2
  end interface operator (-)

  interface operator (*)
     module procedure cross2
  end interface operator (*)

  interface assignment (=)
     module procedure assign2, assign2_array
  end interface assignment (=)

  interface show
     module procedure show2
  end interface show

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

    ret%x = a%x + b%x
    ret%y = a%y + b%y
  end function add2

  function sub2(a, b) result(ret)
    implicit none
    type(vector2), intent(in) :: a, b
    type(vector2) :: ret

    ret%x = a%x - b%x
    ret%y = a%y - b%y
  end function sub2

  function cross2(a, b) result(ret)
    implicit none
    type(vector2), intent(in) :: a, b
    real(8) :: ret

    ret = a%x * b%y - a%y * b%x
  end function cross2

  subroutine assign2(a, b)
    implicit none
    type(vector2), intent(out) :: a
    real(8), intent(in)        :: b

    a%x = b
    a%y = b
  end subroutine assign2

  subroutine assign2_array(a, b)
    implicit none
    type(vector2), intent(out) :: a
    real(8), intent(in)        :: b(2)

    a%x = b(1)
    a%y = b(2)
  end subroutine assign2_array

  subroutine show2(v)
    implicit none
    type(vector2), intent(in) :: v

    write(*, '("vector2 : ", f10.4, ",", f10.4)') v%x, v%y
    return
  end subroutine show2

end module mod_vector

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
end program answer
