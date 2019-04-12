program sample
  implicit none

  integer :: i

  ! 最も基本的な配列の宣言
  integer :: a(5)

  ! 配列の添字範囲を指定して宣言
  integer :: b(0:4)
  integer :: c(6:10)

  ! 実数型
  real(8) :: x(100)
  real(8) :: sum

  ! doループで配列の各要素を処理する
  do i = 1, 5
     a(i) = i
  end do

  do i = 0, 4
     b(i) = i
  end do

  ! 各要素同士の演算も出来る(添字に注意)
  do i = 1, 5
     c(i+5) = 2*a(i) + b(i-1)
  end do

  ! それぞれの値を出力
  do i = 1, 5
     write(*,*) 'a(', i, ') = ', a(i)
  end do

  do i = 0, 4
     write(*,*) 'b(', i, ') = ', b(i)
  end do

  do i = 6, 10
     write(*,*) 'c(', i, ') = ', c(i)
  end do

  ! 値をセットして
  do i = 1, 100
     x(i) = real(i, kind=8)
  end do

  ! 配列の和を求める
  sum = 0.0_8
  do i = 1, 100
     sum = sum + x(i)
  end do

  write(*,*) 'sum = ', sum

  stop
end program sample
