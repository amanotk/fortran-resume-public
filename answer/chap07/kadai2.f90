program answer
  implicit none

  real(8) :: x

  read(*,*) x

  write(*,*) 'sqrt(x) = ', sqrt(x)
  write(*,*) 'appox   = ', mysqrt(x)

  stop
contains
  !
  ! 逐次近似で平方根を求める
  !
  function mysqrt(x) result(y)
    implicit none
    real(8), intent(in) :: x
    real(8) :: y

    real(8), parameter :: epsilon = 1.0e-5
    real(8) :: xx, err

    ! 初期値
    y   = x
    err = 1.0_8

    do while(err > epsilon)
       xx = y
       y  = 0.5_8 * (x/xx + xx)
       err = abs((xx-y)/xx)
    end do

  end function mysqrt
end program answer
