program sample
  implicit none

  integer, parameter :: nmax = 50
  real(8), parameter :: tolerance = 1.0e-6

  logical :: status
  integer :: n
  real(8) :: x, y, x1, x2, sig

  write(*, fmt='(a)', advance='no') 'Input two initial guesses : '
  read(*,*) x1, x2

  ! x1 < x2 となるように交換
  if( x1 >= x2 ) then
     x  = x1
     x1 = x2
     x2 = x
  end if

  ! f(x1)とf(x2)の符号は逆でなければならない
  if( f(x1)*f(x2) >= 0.0 ) then
     write(*,*) 'Signs of two function values must be opposite'
     stop
  end if

  sig = sign(1.0_8, f(x2)-f(x1))
  status = .false.
  do n = 1, nmax
     x = (x1 + x2) * 0.5_8
     y = f(x)

     ! 収束判定
     if (abs(x2-x1) < tolerance) then
        status = .true.
        write(*,fmt='("Converged at step ", i4)') n
        exit
     else
        write(*,fmt='("Error at step ", i4, " = ", e20.8)') n, abs(y)
     end if

     ! 次の値を推定
     if (y*sig < 0.0) then
        x1 = x
     else
        x2 = x
     end if
  end do

  ! 結果の表示
  if (status .eqv. .false.) then
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

end program sample
