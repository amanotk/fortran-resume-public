program sample
  implicit none

  integer, parameter :: winloss(3,3) = &
       & reshape((/ 0, +1, -1, -1,  0, +1, +1, -1, 0/), (/3, 3/))

  character(128) :: ch, cyou, ccom, message
  integer :: you, com
  real(8) :: r

  ! 乱数のseedを設定
  call random_seed_clock()

  !
  ! コンピューターとジャンケン
  !
  ! グー=r, パー=p, チョキ=s を入力する. それ以外を入力すると終了.
  !
  do while(.true.)
     !
     ! ユーザーの手を入力
     !
     write(*, fmt='(/,a)', advance='no') &
          & 'Input (r for rock, p for paper, s for scissors) : '
     read(*,*) ch

     select case(ch)
     case('r')
        you = 1
        write(cyou, fmt='(a)') 'Rock (you)'
     case('p')
        you = 2
        write(cyou, fmt='(a)') 'Paper (you)'
     case('s')
        you = 3
        write(cyou, fmt='(a)') 'Scissors (you)'
     case default
        write(*,*) 'bye'
        exit
     end select

     !
     ! コンピューターの手を乱数で決定
     !
     call random_number(r)

     if (r <= 1.0_8/3.0_8) then
        com = 1
        write(ccom, fmt='(a)') 'Rock (Com)'
     else if (r <= 2.0_8/3.0_8) then
        com = 2
        write(ccom, fmt='(a)') 'Paper (Com)'
     else
        com = 3
        write(ccom, fmt='(a)') 'Scissors (Com)'
     end if

     write(message, fmt='(a, " v.s. ", a)') trim(cyou), trim(ccom)

     select case(winloss(you, com))
     case (-1)
        write(*, '(a, " => ", a)') trim(message), 'You loose !'
     case (0)
        write(*, '(a, " => ", a)') trim(message), 'Even !'
     case (1)
        write(*, '(a, " => ", a)') trim(message), 'You win !'
     case default
        write(*,*) 'Error' ! 念の為エラー処理
     end select

  end do

  stop
contains
  !
  ! 乱数のseedをシステムクロックに応じて変更
  !
  subroutine random_seed_clock()
    implicit none
    integer :: nseed, clock
    integer, allocatable :: seed(:)

    ! システムクロックを取得
    call system_clock(clock)

    call random_seed(size=nseed)
    allocate(seed(nseed))

    seed = clock
    call random_seed(put=seed)

    deallocate(seed)
  end subroutine random_seed_clock

end program sample
