program sample
  implicit none

  integer(4), parameter :: n  = 8_4
  real(8), parameter    :: pi = 3.141592653589_8
  integer(4) :: m
  real(8)    :: f, g

  ! 普通の変数を同じように定数を参照出来る
  m = n * 10
  f = pi * 2
  g = pi * n

  ! 次のような定数変数への代入を行うコードがあるとコンパイルエラーとなる
  ! pi = 3.14

  write(*,*) n
  write(*,*) pi

  stop
end program sample
