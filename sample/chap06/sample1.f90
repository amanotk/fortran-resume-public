program sample
  implicit none

  character(128) :: fmt
  character(128) :: text
  integer :: year = 2014

  real(8) :: x, y, z

  ! 6桁で出力
  write(*, '(i6)') year

  ! 編集記述子を文字型変数として渡す
  fmt = '(i6)'
  write(*, fmt) year

  ! 8桁で出力. ただし6桁に満たない部分は0で埋められる
  write(*, '(i8.6)') + year

  ! 負の整数の場合
  write(*, '(i8.6)') - year

  x = 4.0_8 * atan(1.0_8)
  y = x * 2
  z = x**2

  write(*, '(f12.5)') x
  write(*, '(e20.7)') x

  ! これは正しく出力されない
  write(*, '(f5.3)') x * 10
  write(*, '(e5.3)') x

  ! そのまま出力
  write(*, '(a)') 'I Love Fortran'

  ! 30文字幅で右寄せ
  write(*, '(a30)') 'I Love Fortran'

  ! 6文字分(最初の6文字だけ表示される)
  write(*, '(a6)') 'I Love Fortran'

  ! 複数の記述子を並べる
  write(*, '(e10.3, e10.3, e10.3)') x, y, z

  ! 文字列および改行を使う
  write(*, '("x = ", e10.3, /, "y = ", e10.3, /, "z = ", e10.3)') x, y, z

  ! 出力後に改行しない
  write(*, fmt='(a)', advance='no') 'Input some text : '

  ! 改行まで文字を読み込む
  read(*, '(a)') text

  write(*, *) 'text = ', text

  stop
endprogram sample
