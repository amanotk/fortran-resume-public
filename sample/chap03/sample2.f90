program sample
  implicit none ! 暗黙の型宣言禁止

  ! 整数型
  integer(kind=4) :: i4     ! 4バイト（32ビット）の整数型
  integer(kind=8) :: i8     ! 8バイト（64ビット）の整数型

  ! 実数型
  real(kind=4) :: r4      ! 4バイト（32ビット）の実数型（単精度）
  real(kind=8) :: r8      ! 8バイト（64ビット）の実数型（倍精度）
  real(kind=16) :: r16    ! 16バイト(128ビット）の実数型（4倍精度）

  ! 複素数型（実数2つ分の領域が必要になる）
  complex(kind=4) :: c4     ! 8バイト（64ビット）の複素数型   = 単精度
  complex(kind=8) :: c8     ! 16バイト（128ビット）の複素数型 = 倍精度

  ! ただし'kind='を省略して例えば以下のように宣言しても良い
  real(8) :: x, y, z

  ! 文字列型は少し特殊で通常はkind=1である。文字列の長さはlen=で指定する
  character(len=256) :: char   ! 256文字分

  ! 論理型(このように宣言文で初期化してもよい)
  logical :: torf = .true.

  ! 4バイト整数に値を代入
  i4 = 2048
  write(*, *) i4

  ! 8バイト整数でも同様
  i8 = 2048
  write(*, *) i8

  ! 単精度の実数 (デフォルトでは'_4'を指定したのと同じ)
  r4 = 3.14
  write(*, *) r4

  ! 倍精度の実数 ('_8'でkind=8を指定)
  r8 = 3.14_8
  write(*, *) r8

  ! 複素数型の変数に 2.71 + 0.99 i を代入
  c4 = (2.71, 0.99)
  write(*, *) c4

  ! 同様にkindパラメータを指定可能
  c8 = (2.71_8, 0.99_8)
  write(*, *) c8

  ! 文字型の変数に文字列を代入
  char = 'this is text'

  ! 実数を代入して表示
  x = 3.14
  write(*, *) 'real (original) => ', x

  ! yにxの値を代入
  y = x

  ! xの値を変更
  x = 2.71

  ! yの値を表示（xを変更してもeは変更されない）
  write(*, *) 'real (not modified) => ', y

  ! 論理型の値を表示
  write(*, *) 'logical => ', torf

  stop
endprogram sample
