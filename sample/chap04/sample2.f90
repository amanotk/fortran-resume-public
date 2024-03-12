program sample
  implicit none

  integer, parameter :: lower = 2
  integer, parameter :: upper = 9
  integer, parameter :: stride = 3
  integer :: i, j, sum

  ! 一番シンプルな使い方
  write(*, *) '--- Do loop #1 ---'
  sum = 0
  do i = 1, 10
    sum = sum + i
    write(*, *) i, sum
  enddo

  ! 2個飛ばしのループ
  write(*, *) '--- Do loop #2 ---'
  sum = 0
  do i = 1, 10, 2
    sum = sum + i
    write(*, *) i, sum
  enddo

  ! 変数で範囲やストライドを指定可能
  write(*, *) '--- Do loop #3 ---'
  sum = 0
  do i = lower, upper, stride
    sum = sum + i
    write(*, *) i, sum
  enddo

  ! 多重ループも可能
  write(*, *) '--- Do loop #4 ---'
  do i = 1, 3
    do j = 1, 3
      write(*, *) '(', i, ',', j, ') => ', 3 * (i - 1) + j
    enddo
  enddo

  stop
endprogram sample
