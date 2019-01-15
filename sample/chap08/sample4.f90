program sample
  implicit none

  integer :: n, nmax
  real(8) :: x1, x2, dx, f1, f2, integral, pi

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

  !
  ! 台形公式による数値積分
  !
  integral = 0.5_8 * (f(x1) + f(x2))
  do n = 1, nmax-1
     integral = integral + f(x1 + dx*real(n,8))
  end do
  integral = integral * dx

  write(*, fmt='(a16, " : ", f18.15, " (rel. error = ", e18.12, ")")') &
       & "Trapezoidal rule", integral, abs(integral/pi - 1.0_8)

  !
  ! Simpsonの公式による数値積分
  !
  integral = f(x1) + f(x2)
  ! odd
  do n = 1, nmax-1, 2
     integral = integral + 4.0_8 * f(x1 + dx*real(n,8))
  end do
  ! even
  do n = 2, nmax-2, 2
     integral = integral + 2.0_8 * f(x1 + dx*real(n,8))
  end do
  integral = integral * dx / 3.0_8

  write(*, fmt='(a16, " : ", f18.15, " (rel. error = ", e18.12, ")")') &
       & "Simpson's rule", integral, abs(integral/pi - 1.0_8)

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
