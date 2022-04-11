program answer
  implicit none

  integer :: m, n, l, r

  read(*,*) m, n

  r = mod(m, n)
  do while( r /= 0 )
     m = n
     n = r
     r = mod(m, n)
  end do

  write(*,*) 'Greatest common divisor : ', n

  stop
end program answer
