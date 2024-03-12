module mod_const
  implicit none

  real(8), parameter :: pi = 4.0_8 * atan(1.0_8)
  real(8), parameter :: sqrtpi = sqrt(pi)
  real(8), parameter :: e = exp(1.0_8)
  real(8), parameter :: log2 = log10(2.0_8)

endmodule mod_const

program answer
  use mod_const
  !use mod_const, only: pi
  !use mod_const, only: e => log2
  implicit none

  write(*, '(a20, ":", e12.4)') 'pi', pi
  write(*, '(a20, ":", e12.4)') 'sqrt(pi)', sqrtpi
  write(*, '(a20, ":", e12.4)') 'e', e
  write(*, '(a20, ":", e12.4)') 'log10(2)', log2

  stop
endprogram answer
