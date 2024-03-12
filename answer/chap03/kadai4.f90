program answer
  implicit none

  complex(8), parameter :: cunit = (0.0_8, 1.0_8)
  real(8) :: x, y
  complex(8) :: z

  read(*, *) z

  x = real(z)
  y = aimag(z)

  write(*, *) exp(z)
  write(*, *) exp(x) * (cos(y) + cunit * sin(y))

  stop
endprogram answer
