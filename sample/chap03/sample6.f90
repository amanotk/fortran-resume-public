program sample
  implicit none

  real(8) :: x, y, z

  x = 4.0_8
  y = 6.0_8

  ! 平均値を計算してzに代入
  z = 0.5_8 * (x + y)
  write(*, *) z

  ! x, yが倍精度なので2も倍精度に変換されてから演算が実行される
  z = (x + y) / 2
  write(*, *) z

  ! 以下の代入文は意図した通りに動かない
  ! 右辺は整数同士の演算なので0となり, それが代入時に実数型に変換される
  z = 2 / 3
  write(*, *) z

  ! 右辺は単精度実数として演算されてから倍精度実数に変換されるので精度が落ちる
  z = 2 / 3.0
  write(*, *) z

  ! 右辺も倍精度実数として演算される(期待通りの結果)
  z = 2 / 3.0_8
  write(*, *) z

  ! 明示的に変換する
  z = real(2, kind=8) / real(3, kind=8)
  write(*, *) z

  ! kindを指定しないと右辺の演算は単精度で評価されてしまう
  z = real(2) / real(3)
  write(*, *) z

  stop
endprogram sample
