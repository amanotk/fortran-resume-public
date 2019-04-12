program sample
  implicit none

  character(len=32) :: c_number
  integer :: i_number

  ! 整数を読み込む
  write(*,*) 'Input integer : '
  read(*,*) i_number

  ! 整数の値で場合分け
  select case(i_number)
  case(:-1)     ! 負の値
     write(*,*) 'your input was negative'
  case(0)
     write(*,*) 'your input was zero'
  case(1)
     write(*,*) 'your input was one'
  case(2)
     write(*,*) 'your input was two'
  case(3)
     write(*,*) 'your input was three'
  case default  ! 上記以外全て(>=4)
     write(*,*) 'your input was too large'
  end select

  ! 文字列を読み込む
  write(*,*) ''
  write(*,*) 'Input character : '
  read(*,*) c_number

  ! 文字列の値で場合分け
  select case(c_number)
  case('zero')
     write(*,*) 'your input was 0'
  case('one')
     write(*,*) 'your input was 1'
  case('two')
     write(*,*) 'your input was 2'
  case('three')
     write(*,*) 'your input was 3'
  case default  ! 上記以外全て
     write(*,*) 'unknown input'
  end select

  stop
end program sample
