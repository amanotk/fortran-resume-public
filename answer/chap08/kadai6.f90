program answer
  implicit none

  integer, parameter :: max_memory_mb = 512 ! 最大メモリ使用量 [MB]
  real(8), parameter :: pi = atan(1.0) * 4

  integer :: ndims, trial
  real(8) :: approx, exact

  ! 次元数と試行回数を求める
  read(*,*) ndims, trial

  call random_seed_clock()
  approx = volume(ndims, trial) * 2**ndims
  exact  = pi**(ndims*0.5) / gamma(ndims*0.5 + 1)

  write(*, fmt='("approximation  = ", e20.8)') approx
  write(*, fmt='("exact value    = ", e20.8)') exact
  write(*, fmt='("relative error = ", e20.8)') abs(1 - approx/exact)

  stop
contains

  ! 超球の体積を求める
  real(8) function volume(ndims, trial)
    implicit none
    integer, intent(in) :: ndims
    integer, intent(in) :: trial

    integer :: i, j, k, niter, count, nmax
    real(8), allocatable :: x(:,:)

    ! 乱数生成個数の最大値 (メモリ使用量が大きくなり過ぎないように)
    nmax = max_memory_mb * 2**20 / (8*ndims)

    ! 反復回数
    niter = trial / nmax

    ! モンテカルロ積分
    allocate(x(ndims,nmax))

    count = 0
    do k = 1, niter
       call random_number(x)
       count = count + count_inside(x)
    end do

    call random_number(x)
    count = count + count_inside(x(:,1:mod(trial,nmax)))

    volume = real(count, kind=8) / real(trial, kind=8)

    deallocate(x)

  end function volume

  ! 試行
  integer function count_inside(x)
    real(8), intent(in) :: x(:,:)

    integer :: i, j, n, m
    real(8) :: r

    n = size(x, 1)
    m = size(x, 2)

    ! 条件を満たす要素を数える
    count_inside = 0
    do j = 1, m
       r = sum(x(:,j)**2)

       if( r < 1.0_8 ) then
          count_inside = count_inside + 1
       end if
    end do

  end function count_inside

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

end program answer
