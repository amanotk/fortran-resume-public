! 面積を計算するモジュール
module mod_area
  implicit none

  real(8), parameter :: pi = 4*atan(1.0_8)

  ! 総称名を定義
  interface triangle
     module procedure triangle1, triangle2
  end interface triangle

contains

  ! 底辺と高さが与えられた時の面積の計算
  function triangle1(a, b) result(area)
    real(8), intent(in) :: a, b
    real(8) :: area

    area = a * b / 2

  end function triangle1

  ! 3つの頂点の座標が与えられた時の面積の計算
  function triangle2(x1, y1, x2, y2, x3, y3) result(area)
    real(8), intent(in) :: x1, y1, x2, y2, x3, y3
    real(8) :: area

    area = abs((x2-x1)*(y3-y1) - (x3-x1)*(y2-y1))/2

  end function triangle2

end module mod_area

! メインプログラム
program sample
  use mod_area
  implicit none

  real(8) :: x1, y1, x2, y2, x3, y3, a, b

  write(*, fmt='(a)', advance='no') 'Input height and base of tirangle : '
  read(*,*) a, b

  write(*,*) 'area of triangle = ', triangle(a, b)

  write(*, fmt='(a)', advance='no') 'Input three apexes of triangle : '
  read(*,*) x1, y1, x2, y2, x3, y3

  write(*,*) 'area of triangle = ', triangle(x1, y1, x2, y2, x3, y3)

  stop
end program sample
