program answer
  implicit none

  integer, parameter :: max_line = 256
  integer :: ios, nline, count
  character(max_line) :: line

  count = 0
  nline = 1

  read(*, fmt='(a)', iostat=ios) line

  do while(ios == 0)
    ! remove whitespace
    line = adjustl(line)

    ! count only if the line is not blank or comment
    if(line /= '' .and. line(1:1) /= '!') then
      count = count + 1
    endif

    ! read next line
    read(*, fmt='(a)', iostat=ios) line
    nline = nline + 1
  enddo

  write(*, *) 'Number of lines with valid fortran statement : ', count

  stop
endprogram answer
