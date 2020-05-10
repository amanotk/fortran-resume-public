! リダイレクトを用いて
!   $ ./a.out < sample6.dat
! のようにデータを読み込むこと
program sample
  implicit none

  integer :: i, j
  real(8) :: x(3,4)

  ! 配列のメモリが連続した要素に順に読み込まれる
  read(*,*) x

  do j = 1, m
     do i = 1, n
        write(*,*) i, j, x(i,j)
     end do
  end do

  stop
end program sample
