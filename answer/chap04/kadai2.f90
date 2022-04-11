program answer
  implicit none

  integer :: n, m

  write(*,*) 'Input two integers: '
  read(*,*) n, m

  if( n > m ) then
     write(*,*) n, ' is larger than ', m
  else if (n < m ) then
     write(*,*) n, ' is smaller than ', m
  else
     write(*,*) n, ' is equal to ', m
  end if

  stop
end program answer
