program sample
  implicit none

  integer :: i, n, ios
  real(8) :: x, y

  n = 32

  !
  ! アスキー(formatted)で出力(上書き)
  !
  open(unit=10, iostat=ios, file='ascii.dat', action='write', &
       & form='formatted', status='replace')

  if (ios /= 0) then
     write(*,*) 'Failed to open file for output'
     stop
  end if

  ! ファイル(装置番号=10)にデータを書き出し
  do i = 1, 64
     x = real(i,8)/real(n-1,8)
     y = cos(2*3.1415_8 * x)
     write(10, '(e20.8, e20.8)') x, y
  end do

  close(10)

  !
  ! アスキー(formatted)で読み込み (positionはなくても良い)
  !
  open(unit=20, iostat=ios, file='ascii.dat', action='read', &
       & form='formatted', status='old', position='rewind')

  if (ios /= 0) then
     write(*,*) 'Failed to open file for input'
     stop
  end if

  do i = 1, n
     ! データを読み込んで表示
     read(20,*) x, y
     write(*, '(e20.8, e20.8)') x, y
  end do

  close(20)

  stop
end program sample
