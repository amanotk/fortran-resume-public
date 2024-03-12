program sample
  implicit none

  real(8), parameter :: tolerance = 1.0e-8_8

  real(8) :: x, sqrt_x0, sqrt_x1

  write(*, *) 'Input a positive real number :'
  read(*, *) x

  if(x < 0.0_8) then
    write(*, *) 'Error: input must be a positive value'
    stop
  endif

  ! 初期値
  sqrt_x0 = 1.0_8
  sqrt_x1 = x

  !
  ! 逐次近似によって平方根を求める
  !
  do while(abs((sqrt_x0 - sqrt_x1) / sqrt_x0) > tolerance)
    sqrt_x0 = (sqrt_x0 + sqrt_x1) * 0.5_8
    sqrt_x1 = x / sqrt_x0
  enddo

  ! 結果を表示
  write(*, *) 'approx. = ', sqrt_x1
  write(*, *) 'sqrt(x) = ', sqrt(x)
  write(*, *) 'error   = ', abs(1 - sqrt_x1 / sqrt(x))

  stop
endprogram sample
