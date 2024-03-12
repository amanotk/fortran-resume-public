program answer
  implicit none

  integer, parameter :: days(12) = &
       & (/31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31/)

  integer :: i, m, d, doy

  write(*, *) 'Input month and day : '
  read(*, *) m, d

  doy = 0
  do i = 1, m - 1
    doy = doy + days(i)
  enddo
  doy = doy + d

  write(*, *) 'day of year : ', doy

  stop
endprogram answer
