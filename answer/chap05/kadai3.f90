program answer
  implicit none

  integer, allocatable :: score(:)
  integer :: i, n
  integer :: best, worst
  real(8) :: savg, sstd

  read(*, *) n

  allocate(score(n))
  read(*, *) score

  best = 0
  worst = 100
  savg = 0.0_8
  do i = 1, n
    best = max(best, score(i))
    worst = min(worst, score(i))
    savg = savg + score(i)
  enddo
  savg = savg / n

  sstd = 0.0_8
  do i = 1, n
    sstd = sstd + (score(i) - savg)**2
  enddo
  sstd = sqrt(sstd / n)

  ! 以下のように組み込み関数を用いても良い
!!   best  = maxval(score)
!!   worst = minval(score)
!!   savg  = sum(score)/real(n, kind=8)
!!   sstd  = sqrt(sum((score - savg)**2)/n)

  write(*, *) 'Best               : ', best
  write(*, *) 'Worst              : ', worst
  write(*, *) 'Average            : ', savg
  write(*, *) 'Standard deviation : ', sstd

  deallocate(score)

  stop
endprogram answer
