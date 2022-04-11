program answer
  implicit none

  integer :: i, n
  integer, allocatable :: x(:)

  read(*,*) n

  allocate(x(n))

  read(*,*) x

  call bsort(x)

  do i = 1, n
     write(*,*) x(i)
  end do

  deallocate(x)

  stop
contains
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
