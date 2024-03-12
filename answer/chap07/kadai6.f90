program answer
  implicit none

  integer, parameter :: n = 100
  integer :: i, m, ios
  character(len=10) :: input, x(n), y(n)

  m = 0
  read(*, fmt='(a)', iostat=ios) input

  ! 正常に読み込めていれば(ios = 0, 改行は input = '')
  do while(ios == 0 .and. input /= '')
    x(m + 1) = input
    m = m + 1
    read(*, fmt='(a)', iostat=ios) input
  enddo

  ! ソート
  y(1:m) = x(1:m)
  call bsort(y, m)

  ! 結果の表示
  write(*, fmt='(a)') '*** before sort ***'
  do i = 1, m
    write(*, fmt='(a11)', advance='no') adjustl(x(i))
  enddo
  write(*, *)

  write(*, fmt='(a)') '*** after sort ***'
  do i = 1, m
    write(*, fmt='(a11)', advance='no') adjustl(y(i))
  enddo
  write(*, *)

  stop
contains
  !
  ! 文字列をバブルソートで辞書順にソートする
  !
  subroutine bsort(array, n)
    implicit none
    character(len=10), intent(inout) :: array(:)
    integer, intent(in) :: n

    integer :: i, j

    do i = 1, n
      do j = 1, n - i
        call swapif(array(j), array(j + 1))
      enddo
    enddo

  endsubroutine bsort

  !
  ! a, bが a > b なら交換, それ以外なら何もしない
  !
  subroutine swapif(a, b)
    implicit none
    character(len=10), intent(inout) :: a, b

    character(len=10) :: c

    if(a > b) then
      c = a
      a = b
      b = c
    endif

  endsubroutine swapif

endprogram answer
