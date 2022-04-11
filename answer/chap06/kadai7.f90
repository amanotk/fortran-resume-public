program answer
  implicit none

  integer, parameter :: n = 10
  integer :: i, ios
  real(8) :: x(n)

  open(unit=10, iostat=ios, file='cbinary.dat', action='read', &
       & access='stream', form='unformatted', status='old')

  if( ios /= 0 ) then
     write(*,*) 'Failed to open file'
     stop
  end if

  read(10) x
  close(10)

  write(*,*) 'data read from binary.dat in stream access'
  do i = 1, n
     write(*, '(f5.2)') x(i)
  end do

  stop
end program answer
