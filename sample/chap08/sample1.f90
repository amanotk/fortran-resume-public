program sample
  implicit none

  integer :: i, n
  real(8) :: x, y

  x = 1.0e-15_8

  ! 桁落ちの例
  write(*,*) 'Cancellation of significant digits'
  write(*,'("correct result   : ", e22.15)') x/(sqrt(1+x)+1)
  write(*,'("incorrect result : ", e22.15)') sqrt(1+x) - 1

  ! 情報落ちの例
  n = 10000000
  y = 1.0_8
  do i = 1, n
     y = y + x
  end do

  write(*,*) 'Loss of trailing digits'
  write(*,'("correct result   : ", e22.15)') 1.0_8 + x*n
  write(*,'("incorrect result : ", e22.15)') y

end program sample
