program answer
  implicit none

  real(8), parameter :: c1 =+1.0_8
  real(8), parameter :: c3 =-c1/(3*2*1)
  real(8), parameter :: c5 =-c3/(5*4)
  real(8), parameter :: c7 =-c5/(7*6)
  real(8) :: x

  read(*,*) x

  write(*,*) c1*x
  write(*,*) c1*x + c3*x**3
  write(*,*) c1*x + c3*x**3 + c5*x**5
  write(*,*) c1*x + c3*x**3 + c5*x**5 + c7*x**7
  write(*,*) sin(x)

  stop
end program answer
