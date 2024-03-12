program answer
  implicit none

  integer :: i, n
  real(8) :: x1, x2, integral, err1, err2

  ! 真の値
  integral = 1.0_8

  x1 = 0.0_8
  x2 = 1.0_8

  do i = 1, 16
    n = 2**i
    err1 = abs(trapezoid(n, x1, x2) / integral - 1.0_8)
    err2 = abs(simpson(n, x1, x2) / integral - 1.0_8)
    write(*, fmt='(i8, 1x, e12.4, 1x, e12.4)') n, err1, err2
  enddo

  stop
contains
  ! f(x)
  function f(x) result(ret)
    implicit none
    real(8), intent(in) :: x
    real(8) :: ret

    real(8), parameter :: factor = 1.0_8 / atan(1.0_8)

    ret = factor / (1.0_8 + x**2)
    !ret = 2*x
    !ret = 3*x**2
    !ret = 4*x**3
    !ret = 5*x**4
    !ret = 6*x**5

    return
  endfunction f

  ! 台形公式
  function trapezoid(n, a, b) result(ret)
    implicit none
    integer, intent(in) :: n
    real(8), intent(in) :: a, b
    real(8) :: ret

    integer :: i
    real(8) :: h

    h = (b - a) / n

    ret = 0.5_8 * (f(a) + f(b))
    do i = 1, n - 1
      ret = ret + f(a + h * real(i, 8))
    enddo

    ret = ret * h

  endfunction trapezoid

  ! Simpsonの公式
  function simpson(n, a, b) result(ret)
    implicit none
    integer, intent(in) :: n
    real(8), intent(in) :: a, b
    real(8) :: ret

    integer :: i
    real(8) :: h

    h = (b - a) / n

    ret = f(x1) + f(x2)
    ! odd
    do i = 1, n - 1, 2
      ret = ret + 4.0_8 * f(a + h * real(i, 8))
    enddo
    ! even
    do i = 2, n - 2, 2
      ret = ret + 2.0_8 * f(a + h * real(i, 8))
    enddo

    ret = ret * h / 3.0_8

  endfunction simpson

endprogram answer
