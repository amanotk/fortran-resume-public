program sample
  implicit none

  integer :: n

  ! 動的配列(実行時にしかサイズが分からない場合)
  integer, allocatable :: x(:)

  ! 以下は動的(allocatable)配列の使い方
  write(*,*) 'Input array size: '

  ! 配列サイズ
  read(*,*) n

  ! allocateされていないことを確認してからallocate
  if( .not. allocated(x) ) then
     allocate(x(n))
  else
     write(*,*) 'Error: already allocated'
  end if

  ! 確かにallocateされたか?
  if( allocated(x) ) then
     write(*,*) 'Successfully allocated'
  end if

  ! 配列の各要素を読み込み
  write(*,*) 'Input array elements: '
  read(*,*) x

  ! 出力
  write(*,*) 'allocatable array : ', x

  ! メモリを解放
  deallocate(x)

  stop
end program sample
