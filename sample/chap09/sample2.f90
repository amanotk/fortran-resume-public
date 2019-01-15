! 内部手続き
module mod_integrator
  implicit none

contains
  !
  ! 台形公式による数値積分
  !
  function trapezoid(f, dx) result(ret)
    implicit none
    real(8), intent(in) :: f(:)
    real(8), intent(in) :: dx
    real(8) :: ret

    integer :: i, n

    n = size(f)

    ret = 0.5_8 * (f(1) + f(n))
    do i = 2, n-1
       ret = ret + f(i)
    end do
    ret = ret * dx

  end function trapezoid

  !
  ! Simpson公式による数値積分
  !
  function simpson(f, dx) result(ret)
    implicit none
    real(8), intent(in) :: f(:)
    real(8), intent(in) :: dx
    real(8) :: ret

    integer :: i, n

    n = size(f)

    ! 端点を含めた配列サイズが奇数でなければエラー
    if( mod(n, 2) == 0 ) then
       write(*,*) 'array size must be odd'
       stop
    end if

    ret = f(1) + f(n)
    ! even
    do i = 2, n-1, 2
       ret = ret + 4.0_8 * f(i)
    end do
    ! odd
    do i = 3, n-2, 2
       ret = ret + 2.0_8 * f(i)
    end do
    ret = ret * dx / 3.0_8

  end function simpson
end module mod_integrator

program sample
  use mod_integrator ! モジュールを参照
  implicit none

  integer :: i, nmax
  real(8) :: x1, x2, dx, integral, pi
  real(8), allocatable :: y(:)

  ! 真の値
  pi = atan(1.0_8) * 4.0_8

  write(*, fmt='(a)', advance='no') 'Input number of segments : '
  read(*,*) nmax

  if( mod(nmax,2) /= 0 ) then
     write(*,*) 'Number of segments must be an even number'
     stop
  end if

  x1 = 0.0_8
  x2 = 1.0_8
  dx = (x2 - x1)/nmax

  ! 配列サイズはnmax+1
  allocate(y(nmax+1))

  ! 関数を評価して配列に代入
  do i = 1, nmax+1
     y(i) = f(x1 + dx*real(i-1,8))
  end do

  ! 台形公式による数値積分
  integral = trapezoid(y, dx)
  write(*, fmt='(a16, " : ", f18.15, " (rel. error = ", e18.12, ")")') &
       & "Trapezoidal rule", integral, abs(integral/pi - 1.0_8)

  ! Simpsonの公式による数値積分
  integral = simpson(y, dx)
  write(*, fmt='(a16, " : ", f18.15, " (rel. error = ", e18.12, ")")') &
       & "Simpson's rule", integral, abs(integral/pi - 1.0_8)

  deallocate(y)

  stop
contains
  ! 被積分関数
  function f(x) result(ret)
    implicit none
    real(8), intent(in) :: x
    real(8) :: ret

    ret = 4.0_8 / (1.0_8 + x**2)

    return
  end function f
end program sample
