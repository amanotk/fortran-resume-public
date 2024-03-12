program answer
  implicit none

  integer, parameter :: n = 32
  integer :: i, ios
  real(8) :: x(n), y(n), z(n)

  open(unit=10, iostat=ios, file='helix1.dat', action='read', &
       & form='formatted', status='old')

  if(ios /= 0) then
    write(*, *) 'Failed to open a file'
    stop
  endif

  do i = 1, n
    read(10, *) x(i), y(i), z(i)
  enddo

  close(10)

  do i = 1, n
    write(*, '(f5.2, 1x, f5.2, 1x, f5.2)') x(i), y(i), z(i)
  enddo

  stop
endprogram answer
