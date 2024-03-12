program sample
  implicit none

  ! 4バイトの実数型（一度に複数の変数を宣言することもできる）
  real(4) :: a, b, c, d, e

  ! 8バイトの実数型
  real(8) :: x

  !
  ! 四則演算およびべき乗
  !
  write(*, *) 'addition       => ', 2.0 + 3.0  ! 足し算
  write(*, *) 'subtraction    => ', 5.0 - 3.0  ! 引き算
  write(*, *) 'multiplication => ', 2.0 * 3.0  ! 掛け算
  write(*, *) 'division       => ', 5.0 / 2.0  ! 割り算
  write(*, *) 'power          => ', 2.0**3.0   ! べき乗

  !
  ! 演算の優先順位: べき乗 > 掛け算 =割り算 > 足し算 =引き算
  ! 可読性のためにも括弧()で明示的に演算の順番が分かるようにしておくほうが良い。
  !
  write(*, *) 'w/  parenthesis => ', 2.0 * (2.0 + 3.0)   ! 括弧あり => 10.0
  write(*, *) 'w/o parenthesis => ', 2.0 * 2.0 + 3.0     ! 括弧なし => 7.0

  !
  ! 四則演算と代入を同時に
  !
  a = 2.0         ! 変数aに代入
  b = a + 3.0     ! 足し算（a + 3.0）の結果をbに代入
  c = a - 1.0     ! 引き算 (a - 1.0) の結果をcに代入
  d = a * b       ! 掛け算（a * b）の結果をdに代入
  e = a / b       ! 割り算 (a / b）の結果edに代入

  write(*, *) 'substitution   => ', a
  write(*, *) 'addition       => ', b
  write(*, *) 'subtraction    => ', c
  write(*, *) 'multiplication => ', d
  write(*, *) 'division       => ', e

  !
  ! 標準入力から値を読み込み変数xに代入
  !
  write(*, *)
  write(*, *) 'Input a real number: '
  read(*, *) x

  !
  ! 標準で様々な関数が用意されている
  ! 以下はほんの一例
  !
  ! 平方根     => sqrt(x)
  ! 絶対値     => abs(x)
  ! 三角関数   => sin(x), cos(x), tan(x)
  ! 指数関数   => exp(x)
  ! 対数関数   => log(x), log10(x)
  ! 双極関数   => sinh(x), cosh(x), tanh(x)
  ! 逆三角関数 => asin(x), acos(x), atan(x)
  !
  write(*, *) sin(x) ! sin(x)を計算し表示
  write(*, *) cos(x) ! cos(x)を計算し表示

  stop
endprogram sample
