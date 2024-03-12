program answer
  implicit none

  integer, parameter :: nh = 10
  integer :: i, n, hist(nh)
  real(8) :: binc(nh)
  integer, allocatable :: score(:)

  read(*, *) n

  allocate(score(n))

  read(*, *) score

  call histogram(score, 100 / nh, binc, hist)

  do i = 1, nh
    write(*, *) binc(i), hist(i)
  enddo

  deallocate(score)

  stop
contains
  !
  ! ヒストグラムを作成するサブルーチン
  !
  subroutine histogram(score, binw, binc, hist)
    implicit none
    integer, intent(in) :: score(:)  ! 点数(人数分)
    integer, intent(in) :: binw      ! ビンの幅(例えば10点)
    real(8), intent(out) :: binc(:)   ! ビンの中央値(例えば5, 15, ..., 95)
    integer, intent(out) :: hist(:)   ! 各ビン内の人数

    integer :: i, j, n, m

    n = size(score)
    m = size(binc)
    hist = 0

    do i = 1, n
      j = score(i) / binw + 1

      ! 添字範囲をチェック
      if(j < 1 .or. j > m) then
        write(*, *) 'Invalid input'
        stop
      endif

      hist(j) = hist(j) + 1
    enddo

    do i = 1, size(hist)
      binc(i) = (i - 1 + 0.5_8) * binw
    enddo

  endsubroutine histogram
endprogram answer
