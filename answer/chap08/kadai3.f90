program answer
  implicit none

  integer, parameter :: nmax = 20
  real(8), parameter :: epsilon = 1.0e-308_8
  real(8), parameter :: rm = sqrt(1836.0_8)

  integer :: i
  real(8) :: x1, x2
  real(8) :: err1(nmax), err2(nmax), err3(nmax)

  ! bisection method
  x1 =-2.6_8
  x2 =-2.4_8
  call bisection(x1, x2, err1)

  ! secant method
  x1 = 1.0_8
  x2 = 0.0_8
  call secant(x1, x2, err2)

  ! newton method
  x1 = 0.0_8
  call newton(x1, err3)

  do i = 1, nmax
     write(*, '(i3, 1x, e12.4, 1x, e12.4, 1x, e12.4)') &
          & i, err1(i), err2(i), err3(i)
  end do

contains

  ! f(x)
  function f(x) result(y)
    implicit none
    real(8), intent(in) :: x
    real(8) :: y

    y = (1.0_8-x)/rm - exp(x)
  end function f

  ! f'(x)
  function df(x) result(y)
    implicit none
    real(8), intent(in) :: x
    real(8) :: y

    y = -1.0_8/rm - exp(x)
  end function df

  ! 二分法
  subroutine bisection(x1, x2, error)
    implicit none
    real(8), intent(inout) :: x1, x2
    real(8), intent(out) :: error(nmax)

    integer :: n
    real(8) :: x, y, sig

    ! x1 < x2 とする
    if( x1 >= x2 ) then
       x  = x1
       x1 = x2
       x2 = x1
    end if

    ! f(x1)とf(x2)の符号は逆
    if( f(x1)*f(x2) >= 0.0 ) then
       write(*,*) 'The signs of f(x1) and f(x2) must be opposite'
       return
    end if

    sig = sign(1.0_8, f(x2)-f(x1))
    do n = 1, nmax
       x = (x1 + x2) * 0.5_8
       error(n) = abs(x - x1)

       y = f(x)
       if (y*sig < 0.0) then
          x1 = x
       else
          x2 = x
       end if
    end do

    x1 = x
    return
  end subroutine bisection

  ! Secant method (割線法)
  subroutine secant(x1, x2, error)
    implicit none
    real(8), intent(inout) :: x1, x2
    real(8), intent(out) :: error(nmax)

    integer :: n
    real(8) :: dx, dy, y1, y2

    y1 = f(x1)
    y2 = f(x2)
    do n = 1, nmax
       dy = (x2 - x1)/(y2 - y1 + epsilon)
       dx =- y2 * dy
       error(n) = abs(dx)
       x1 = x2
       x2 = x2 + dx
       y1 = y2
       y2 = f(x2)
    end do

    x1 = x2
    return
  end subroutine secant


  ! Newton法
  subroutine newton(x, error)
    implicit none
    real(8), intent(inout) :: x
    real(8), intent(out) :: error(nmax)

    integer :: n
    real(8) :: dx

    do n = 1, nmax
       dx =- f(x) / (df(x) + epsilon)
       x  = x + dx
       error(n) = abs(dx)
    end do

    return
  end subroutine newton

end program answer
