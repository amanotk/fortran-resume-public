program answer
  implicit none

  character(len=128) :: input

  do while(.true.)
    read(*, *) input
    select case(input)
    case('apple', 'orange', 'banana')
      write(*, *) 'food'
    case('dog', 'cat', 'lion')
      write(*, *) 'animal'
    case('car', 'airplane', 'motorcycle')
      write(*, *) 'vehicle'
    case('exit')
      write(*, *) 'Now exit program...'
      exit
    case default
      write(*, *) 'others'
    endselect
  enddo

  stop
endprogram answer
