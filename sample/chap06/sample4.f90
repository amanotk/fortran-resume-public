program sample
  implicit none

  integer :: i, n, ios
  real(8), allocatable :: x(:), y(:), xx(:), yy(:)

  n = 32
  write(*, fmt='("Array size for output = ", i5)') n

  allocate(x(n))
  allocate(y(n))

  do i = 1, n
     x(i) = real(i,8) / real(n-1,8)
     y(i) = sin(4*3.1415_8*x(i)) * cos(2*3.1415_8*x(i))
  end do

  !
  ! バイナリ(unformatted)で出力(上書き)
  !
  open(unit=10, iostat=ios, file='binary.dat', action='write', &
       & form='unformatted', status='replace')

  if (ios /= 0) then
     write(*,*) 'Failed to open file for output'
     stop
  end if

  ! 配列サイズの出力
  write(10) n

  ! 配列の出力
  write(10) x, y

  close(10)


  !
  ! バイナリ(unformatted)で読み込み
  !
  open(unit=20, iostat=ios, file='binary.dat', action='read', &
       & form='unformatted', status='old')

  if (ios /= 0) then
     write(*,*) 'Failed to open file for input'
     stop
  end if

  ! 配列サイズを読み込む
  read(20) n

  allocate(xx(n))
  allocate(yy(n))

  ! 配列を読み込む
  read(20) xx, yy

  close(20)

  ! データが等しいかどうかをチェックする
  do i = 1, n
     if( x(i) /= xx(i) .or. y(i) /= yy(i) ) then ! 厳密に等しいハズ
        write(*,*) 'Error !'
        stop
     end if
  end do

  write(*,*) 'Binary read/write success !'

  deallocate(x)
  deallocate(y)
  deallocate(xx)
  deallocate(yy)

  stop
end program sample
