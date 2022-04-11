program answer
  implicit none

  integer :: i, nr, nbin
  real(8), allocatable :: r(:), hist(:), binc(:)
  real(8) :: xmin, xmax, lambda

  lambda = 1.0_8
  xmin   = 0.0_8  / lambda
  xmax   = 12.0_8 / lambda

  nr   = 60000
  nbin = 24
  allocate(r(nr))
  allocate(hist(nbin))
  allocate(binc(nbin))

  call random_seed_clock()
  call rand_exp(r, lambda)
  call histogram(r, xmin, xmax, nbin, binc, hist)

  do i = 1, nbin
     write(*, fmt='(e12.4, 1x, e12.4)') binc(i), hist(i)
  end do

  deallocate(r)
  deallocate(hist)
  deallocate(binc)

  stop
contains

  ! 指数乱数
  subroutine rand_exp(r, lambda)
    implicit none
    real(8), intent(out) :: r(:)
    real(8), intent(in) :: lambda

    real(8) :: ur(size(r))

    call random_number(ur)
    r = -log(1 - ur)/lambda

  end subroutine rand_exp

  ! 乱数のseedをシステムクロックに応じて変更
  subroutine random_seed_clock()
    implicit none
    integer :: nseed, clock
    integer, allocatable :: seed(:)

    call system_clock(clock)

    call random_seed(size=nseed)
    allocate(seed(nseed))

    seed = clock
    call random_seed(put=seed)

    deallocate(seed)
  end subroutine random_seed_clock

  ! ヒストグラムを作成
  subroutine histogram(x, xmin, xmax, nbin, binc, hist)
    implicit none
    real(8), intent(in) :: x(:)
    real(8), intent(in) :: xmin, xmax
    integer, intent(in) :: nbin
    real(8), intent(out) :: binc(nbin)
    real(8), intent(out) :: hist(nbin)

    integer :: i, j
    real(8) :: h, norm

    h    = (xmax - xmin) / nbin
    norm = 1.0_8 / (size(x) * h)
    hist = 0.0_8

    do i = 1, size(x)
       j = int( x(i)/h ) + 1
       if( j < 1 .or. j > nbin ) cycle

       hist(j) = hist(j) + 1.0_8 * norm
    end do

    do j = 1, nbin
       binc(j) = (j - 0.5_8) * h
    end do

  end subroutine histogram

end program answer
