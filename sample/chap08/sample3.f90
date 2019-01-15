program sample
  implicit none

  integer, parameter :: nmax = 20
  real(8), parameter :: tolerance = 1.0e-6

  logical :: status
  integer :: n
  real(8) :: x, y, dx, dy

  write(*, fmt='(a)', advance='no') 'Input a initial guess : '
  read(*,*) x

  status = .false.
  do n = 1, nmax
     ! 次の値の推定
     y  = f(x)
     dy = df(x)
     dx =-y / dy
     x  = x + dx

     ! 収束判定
     if (abs(dx) < tolerance) then
        status = .true.
        write(*,fmt='("Converged at step ", i4)') n
        exit
     else
        write(*,fmt='("Error at step ", i4, " = ", e20.8)') n, abs(y)
     end if
  end do

  ! 結果の表示
  if(.not. status) then
     write(*, fmt='("Failed to find a root after ", i3, " iterations")') nmax
  end if

  write(*, fmt='("Final approximation = ", e20.8)') x
  write(*, fmt='("Final error         = ", e20.8)') abs(y)

  stop
contains
  ! 方程式
  function f(x) result(ret)
    implicit none
    real(8), intent(in) :: x
    real(8) :: ret

    ret = x - cos(x)

    return
  end function f

  ! 方程式の微分
  function df(x) result(ret)
    implicit none
    real(8), intent(in) :: x
    real(8) :: ret

    ret = 1.0_8 + sin(x)

    return
  end function df

end program sample
