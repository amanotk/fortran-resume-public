program sample
  implicit none

  integer, parameter :: n = 8
  integer, parameter :: m = 10
  real(8), parameter :: pi = atan(1.0_8) * 4.0_8

  integer :: i

  real(8) :: x(m), y(m/2)
  real(8) :: a(n), b(n), c(n)

  ! 値をセット
  do i = 1, n
     a(i) = 2*pi * real(i-1, kind=8) / real(n-1, kind=8)
  end do

  do i = 1, m
     x(i) = real(i, kind=8)
  end do

  !
  ! 配列演算: 適宜コメントアウトするなどして結果を確かめること
  !

  ! 代入
  do i = 1, n
     b(i) = a(i)
  end do

  ! 配列演算による代入(上のdoループと同じ)
  b = a

  write(*,*) 'b = ', b

  ! 演算
  do i = 1, n
     c(i) = 0.5_8*a(i) + cos(b(i))
  end do

  ! 配列演算(上のdoループと同じ)
  c = 0.5_8*a + cos(b)

  write(*,*) 'c = ', c

  !
  ! 部分配列と配列演算の組合わせ
  !
  y = 2*x(1:m:2) + 1

  write(*,*) 'y = ', y

  stop
end program sample
