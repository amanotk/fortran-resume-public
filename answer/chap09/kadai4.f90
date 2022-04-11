module mod_vector
  implicit none
  private

  type :: vector2
     real(8) :: x, y
  end type vector2

  type :: vector3
     real(8) :: x, y, z
  end type vector3

  interface operator (+)
     module procedure add2, add3
  end interface operator (+)

  interface operator (-)
     module procedure sub2, sub3
  end interface operator (-)

  interface operator (*)
     module procedure cross2, cross3
  end interface operator (*)

  interface assignment (=)
     module procedure assign2, assign2_array, assign3, assign3_array
  end interface assignment (=)

  interface show
     module procedure show2, show3
  end interface show

  public :: vector2, vector3
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

  !
  ! 3次元ベクトル用演算子
  !
  function add3(a, b) result(ret)
    implicit none
    type(vector3), intent(in) :: a, b
    type(vector3) :: ret

    ret%x = a%x + b%x
    ret%y = a%y + b%y
    ret%z = a%z + b%z
  end function add3

  function sub3(a, b) result(ret)
    implicit none
    type(vector3), intent(in) :: a, b
    type(vector3) :: ret

    ret%x = a%x - b%x
    ret%y = a%y - b%y
    ret%z = a%z - b%z
  end function sub3

  function cross3(a, b) result(ret)
    implicit none
    type(vector3), intent(in) :: a, b
    type(vector3) :: ret

    ret%x = a%y * b%z - a%z * b%y
    ret%y = a%z * b%x - a%x * b%z
    ret%z = a%x * b%y - a%y * b%x
  end function cross3

  subroutine assign3(a, b)
    implicit none
    type(vector3), intent(out) :: a
    real(8), intent(in)        :: b

    a%x = b
    a%y = b
    a%z = b
  end subroutine assign3

  subroutine assign3_array(a, b)
    implicit none
    type(vector3), intent(out) :: a
    real(8), intent(in)        :: b(3)

    a%x = b(1)
    a%y = b(2)
    a%z = b(3)
  end subroutine assign3_array

  subroutine show3(v)
    implicit none
    type(vector3), intent(in) :: v

    write(*, '("vector3 : ", f10.4, ",", f10.4, ",", f10.4)') v%x, v%y, v%z
    return
  end subroutine show3

end module mod_vector

program answer
  use mod_vector
  implicit none

  type(vector2) :: a, b, c
  type(vector3) :: x, y, z

  write(*, fmt='(a)') '--- vector2 ---'

  a = (/1.0_8, 0.0_8/)
  b = 1.0_8
  c = a + b

  call show(a + b)
  call show(a - b)

  write(*, fmt='("a * b = ", f12.4)') a*b

  write(*, fmt='(a)') '--- vector3 ---'

  x = (/1.0_8, 0.0_8, 0.0_8/)
  y = 1.0_8
  z = x * y

  call show(x)
  call show(y)
  call show(z)
  call show(x+y)
  call show(x-y)

  stop
end program answer
