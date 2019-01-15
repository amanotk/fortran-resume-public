program sample
  implicit none

  integer :: i
  real(8) :: x, y, pi, t1, t2

  call cpu_time(t1)

  do i = 1, 20000000
     pi = 4.0_8 * atan(1.0_8)
     y  = cos(2*pi*x)
     x  = y
  end do

  call cpu_time(t2)

  write(*,'("CPU Time [sec] : ", e12.4)') t2 - t1

  stop
end program sample
