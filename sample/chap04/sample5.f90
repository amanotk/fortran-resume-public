program sample
  implicit none

  character(len=32) :: c
  integer :: i, score

  ! 整数を読み込む
  write(*,*) 'Input integer : '
  read(*,*) i

  ! 整数の値で場合分け
  select case(i)
  case(0)        ! i == 0 のとき
     write(*,*) 'your input was zero'
  case(1)        ! i == 1 のとき
     write(*,*) 'your input was one'
  case(2)        ! i == 2 のとき
     write(*,*) 'your input was two'
  case(3)        ! i == 3 のとき
     write(*,*) 'your input was three'
  case default   ! 上記以外全て
     write(*,*) 'your input was too large'
  end select


  ! 点数を読み込む
  write(*,*) ''
  write(*,*) 'Input score : '
  read(*,*) score

  select case(score)
  case(0)              ! 0点
     write(*,*) 'zero'
  case(1:29)           ! 1-29点
     write(*,*) 'poor'
  case(30:59)          ! 30-59点
     write(*,*) 'fair'
  case(60:89)          ! 60-89点
     write(*,*) 'good'
  case(90:100)         ! 90-100点
     write(*,*) 'excellent'
  case default         ! それ以外
     write(*,*) 'invalid input'
  end select


  ! 文字列を読み込む
  write(*,*) ''
  write(*,*) 'Input language : '
  read(*,*) c

  ! 文字列の値で場合分け
  select case(c)
  case('c', 'c++', 'fortran')
     write(*,*) 'compiled language'
  case('python', 'perl', 'ruby')
     write(*,*) 'script language'
  case('english', 'japanese', 'french', 'chinese')
     write(*,*) 'natural language'
  case default
     write(*,*) 'others'
  end select

  stop
end program sample
