program answer
  implicit none

  integer, parameter :: n = 32
  integer :: i, j, ios
  real(8) :: xyz(n, 3)
  character(20) :: files(3)

  open(unit=10, iostat=ios, file='helix1.dat', action='read', &
       & form='formatted', status='old')

  if(ios /= 0) then
    write(*, *) 'Failed to open a file'
    stop
  endif

  do i = 1, n
    read(10, *) xyz(i, 1), xyz(i, 2), xyz(i, 3)
  enddo

  close(10)

  ! 別ファイルに出力
  files(1) = 'x.dat'
  files(2) = 'y.dat'
  files(3) = 'z.dat'

  do j = 1, 3
    open(unit=20, iostat=ios, file=files(j), action='write', &
         & form='formatted', status='replace')

    if(ios /= 0) then
      write(*, *) 'Failed to open a file'
      cycle
    endif

    do i = 1, n
      write(20, '(f5.2)') xyz(i, j)
    enddo

    close(20)
  enddo

  stop
endprogram answer
