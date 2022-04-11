program answer
  implicit none

  real(8) :: a, b, c, d, x1, x2, y1, y2, e1, e2, e3, e4

  write(*, fmt='(a)', advance='no') 'Input coefficients (a, b, c) : '
  read(*,*) a, b, c

  if( b**2 < 4*a*c ) then
     write(*,*) 'No real solutions'
     stop
  end if

  d = sqrt(b**2 - 4*a*c)

  ! 普通に求めた解および規格化された誤差
  x1 = (-b + d)/(2*a)
  x2 = (-b - d)/(2*a)

  e1 = (a*x1**2 + b*x1 + c)/max(a*x1**2, b*x1, c)
  e2 = (a*x2**2 + b*x2 + c)/max(a*x2**2, b*x2, c)

  ! 桁落ち対策
  if( b*d > 0 ) then
     ! x1の精度が悪い可能性有り
     y1 = 2*c/(-b - d)
     y2 = x2
  else
     ! x2の精度が悪い可能性有り
     y1 = x1
     y2 = 2*c/(-b + d)
  end if

  write(*, fmt='("roots without correction = ", e24.16, 3x, e24.16)') x1, x2
  write(*, fmt='("roots with    correction = ", e24.16, 3x, e24.16)') y1, y2

  stop
end program answer

