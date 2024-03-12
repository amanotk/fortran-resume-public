program sample
  implicit none

  real(8) :: x, y

  write(*, *) 'Input two real numbers: '

  ! 整数を読み込む
  read(*, *) x, y

  write(*, *) 'average = ',(x + y) / 2

  stop
endprogram sample
