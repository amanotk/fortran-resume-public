program answer
  implicit none

  integer :: i, j

  do i = 1, 9
    do j = 1, 9
      write(*, fmt='(i4)', advance='no') i * j
    enddo
    write(*, *)
  enddo

  stop
endprogram answer
