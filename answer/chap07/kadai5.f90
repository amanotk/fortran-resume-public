program answer
  implicit none

  character(len=128), parameter :: datafile = 'rand.dat'

  integer :: i, n, ios, to_be_found
  integer, allocatable :: x(:)

  ! データファイルの読み込み
  open(unit=10, iostat=ios, file=datafile, action='read', &
       & form='formatted', status='old')

  if( ios /= 0 ) then
     write(*,*) 'Failed to open file'
  end if

  read(10,*) n

  allocate(x(n))

  read(10,*) x

  close(10)

  ! ソート
  call bsort(x)

  ! 見つけたい数を読み込む
  write(*, fmt='(a)', advance='no') 'Input an integer : '
  read(*,*) to_be_found

  ! 二分探索で見つける
  call bsearch(x, to_be_found, i)

  if( i /= -1) then
     write(*,'(i8, a, i8)') to_be_found, ' was fouund at index ', i
  else
     write(*,'(i8, a)') to_be_found, ' was not found !'
  end if

  deallocate(x)

  stop
contains
  !
  ! 二分探索
  !
  subroutine bsearch(array, var, index)
    implicit none
    integer, intent(in)  :: array(:) ! ソートされた配列
    integer, intent(in)  :: var      ! 探したい値
    integer, intent(out) :: index    ! 見つかった要素へのインデックス

    integer :: left, right, middle

    index =-1
    left  = 1
    right = size(array)

    do while( left <= right )
       middle = (left + right)/2
       if( array(middle) == var ) then
          index = middle
          exit
       else if( array(middle) > var ) then
          right = middle - 1
       else if( array(middle) < var ) then
          left  = middle + 1
       end if
    end do

  end subroutine bsearch

  !
  ! バブルソート
  !
  subroutine bsort(array)
    implicit none
    integer, intent(inout) :: array(:) ! 配列にはソートされた結果が代入される

    integer :: i, j, n

    n = size(array)
    do i = 1, n
       do j = 1, n-i
          call swapif(array(j), array(j+1))
       end do
    end do

  end subroutine bsort

  !
  ! a, bが a > b なら交換, それ以外なら何もしない
  !
  subroutine swapif(a, b)
    implicit none
    integer, intent(inout) :: a, b

    integer :: c

    if( a > b ) then
       c = a
       a = b
       b = c
    end if

  end subroutine swapif

end program answer
