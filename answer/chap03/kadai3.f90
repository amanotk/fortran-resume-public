program answer
  implicit none

  real(4)  :: pi4
  real(8)  :: pi8
  real(16) :: pi16

  pi4  = atan(1.0_4 ) * 4.0_4
  pi8  = atan(1.0_8 ) * 4.0_8
  pi16 = atan(1.0_16) * 4.0_16

  write(*,*) real(pi4, 16), abs(1 - pi4/pi16)
  write(*,*) real(pi8, 16), abs(1 - pi8/pi16)
  write(*,*) real(pi16, 16)

  stop
end program answer
