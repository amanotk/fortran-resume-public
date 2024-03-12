program answer
  implicit none

  integer, parameter :: n = 32
  integer :: i, ios
  real(8) :: x(n), y(n), z(n)

  open(unit=10, iostat=ios, file='helix2.dat', action='read', &
       & form='unformatted', status='old')

  if(ios /= 0) then
    write(*, *) 'Failed to open file'
    stop
  endif

  read(10) x
  read(10) y
  read(10) z

  close(10)

  do i = 1, n
    write(*, '(f5.2, 1x, f5.2, 1x, f5.2)') x(i), y(i), z(i)
  enddo

  stop
endprogram answer
