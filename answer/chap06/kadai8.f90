program answer
  implicit none

  integer, parameter :: n = 32
  integer :: i, ios, header, footer
  real(8) :: x(n), y(n), z(n)

  open(unit=10, iostat=ios, file='helix2.dat', action='read', &
       & access='stream', form='unformatted', status='old')

  if( ios /= 0 ) then
     write(*,*) 'Failed to open file'
     stop
  end if

  ! read x
  read(10) header
  read(10) x
  read(10) footer

  ! read y
  read(10) header
  read(10) y
  read(10) footer

  ! read z
  read(10) header
  read(10) z
  read(10) footer

  close(10)

  do i = 1, n
     write(*, '(f5.2,x,f5.2,x,f5.2)') x(i), y(i), z(i)
  end do

  stop
end program answer
