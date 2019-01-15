program sample
  implicit none

  integer :: increment, count

  ! 初期化
  count = 0

  ! 無限ループ
  do while( .true. )
     ! 標準入力から読み込む
     write(*,*) ''
     write(*,*) 'Input a positive integer (less than 10): '
     read(*,*) increment

     if ( increment <= 0 ) then
        write(*,*) 'error : input <= 0'
        exit   ! ループを抜ける
     else if ( increment >= 10 ) then
        write(*,*) 'error : input >= 10'
        cycle  ! ループの先頭へ(これ以下の処理は行わない)
     end if

     ! countを増やす
     count = count + increment

     write(*,*) 'current count = ', count
  end do

  write(*,*) 'last count = ', count

  stop
end program sample
