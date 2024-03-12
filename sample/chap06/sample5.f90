program sample
  implicit none

  character(len=*), parameter :: text = 'initialization by this string'
  character(len=16) :: a, b, c, d
  character(len=64) :: str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  integer :: i1, i2, n

  a = 'This'
  b = 'is'
  c = 'a'
  d = 'pen'

  ! 何も考えずに出力
  write(*, *) a, b, c, d

  ! 文字列を結合して出力
  write(*, *) a//b//c//d

  ! 6文字分ずつ
  write(*, '(a6,a6,a6,a6)') a, b, c, d

  ! 間の空白無し
  write(*, '(a)') trim(a)//trim(b)//trim(c)//trim(d)

  ! 空白を削除して結合
  write(*, '(a,x,a,x,a,x,a)') trim(a), trim(b), trim(c), trim(d)

  ! XYZと一致する部分文字列を検索し, 開始位置のインデックスを返す
  i1 = index(str, 'XYZ')
  i2 = i1 + len('XYZ')
  write(*, *) str(i1:i2)  ! XYZを出力

  ! 内部ファイルを用いて連番のファイル名を作成
  do n = 1, 8
    write(str, '("data",i3.3,".dat")') n
    write(*, '(a)') str
  enddo

  stop
endprogram sample
