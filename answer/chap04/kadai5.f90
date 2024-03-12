program answer
  implicit none

  logical :: status
  integer :: i, n, m
  real(8) :: epsilon, e, c, etrue, error

  read(*, *) n

  if(n <= 1) then
    write(*, *) 'Number of terms must be greater than 1'
    stop
  endif

  read(*, *) epsilon

  if(epsilon < 0.0_8 .or. epsilon > 1.0_8) then
    write(*, *) 'Tolerance must be in a range 0 < epsilon < 1'
    stop
  endif

  status = .false.
  etrue = exp(1.0_8)
  e = 1.0_8
  c = 1.0_8
  m = n
  do i = 1, n
    c = c / i
    e = e + c
    error = abs(e - etrue) / etrue
    if(error < epsilon) then
      status = .true.
      m = i
      exit
    endif
  enddo

  if(status) then
    write(*, *) 'Converged !'
  else
    write(*, *) 'Did not converge !'
  endif

  write(*, *) 'N                  : ', m
  write(*, *) 'Exact value        : ', etrue
  write(*, *) 'Approximated value : ', e
  write(*, *) 'Error              : ', error

  stop
endprogram answer
