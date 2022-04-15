program answer
  implicit none

  real(8), parameter :: pi = atan(1.0_8) * 4.0_8
  integer :: i, n
  real(8) :: theta, radian, theta1, theta2, dtheta

  theta1 = 0.0_8
  theta2 = 180.0_8
  dtheta = 10.0_8

  n = int((theta2 - theta1)/dtheta)

  do i = 0, n
     theta = dtheta * i
     radian = theta / 180.0_8 * pi
     write(*,*) theta, sin(radian), cos(radian)
  end do

  stop
end program answer
