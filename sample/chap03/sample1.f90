program sample
  implicit none ! 暗黙の型宣言禁止

  ! 変数を使う前には必ず以下のように宣言を行う
  integer :: n ! 整数型の変数の宣言
  real :: x    ! 実数型の変数の宣言

  ! 代入
  n = 10
  x = 3.14

  ! 表示
  write(*,*) 'integer => ', n
  write(*,*) 'real => ', x

  stop
end program sample
