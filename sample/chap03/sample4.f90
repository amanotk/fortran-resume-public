program sample
  implicit none

  integer :: x

  write(*,*) 'Input integer: '

  ! 整数を読み込む
  read(*,*) x

  write(*,*) 'x * 2 = ', x*2

  stop
end program sample
