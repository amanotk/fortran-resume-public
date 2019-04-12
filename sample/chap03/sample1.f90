program sample
  implicit none ! 暗黙の型宣言禁止

  ! 変数を使う前には必ず以下のように宣言を行う
  integer :: n ! 整数型の変数の宣言
  real :: x    ! 実数型の変数の宣言

  ! 整数を代入して表示
  n = 10
  write(*,*) 'integer => ', n

  ! 実数を代入して表示
  x = 3.14
  write(*,*) 'real => ', x

  stop
end program sample
