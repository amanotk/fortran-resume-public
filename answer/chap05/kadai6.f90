program answer
  implicit none

  integer :: i, j, n
  logical, allocatable :: prime(:)

  read(*, *) n
  allocate(prime(n))

  prime = .true.
  do i = 2, n
    if(.not. prime(i)) then
      cycle
    endif

    write(*, *) 'prime number : ', i

    j = 1
    do while(i * j <= n)
      prime(i * j) = .false.
      j = j + 1
    enddo
  enddo

  deallocate(prime)

  stop
endprogram answer
