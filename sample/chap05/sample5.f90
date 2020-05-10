! リダイレクトを用いて
!   $ ./a.out < sample5.dat
! のようにデータを読み込むこと
program sample
  implicit none

  integer :: i
  real(8) :: x(10), y(10), z(10)

  ! doループで全要素を順に読み込む
  ! この場合は改行があっても構わない
  read(*,*) x

  ! このように書いても動作は同じ
  read(*,*) (y(i), i = 1, 10)

  ! よく理解していない場合にはこの形式は使わない方がよい
  ! 1行に一つの要素が書かれている場合の読み込みはこれでよい
  do i = 1, 10
     read(*,*) z(i)
  end do

  ! doループで全要素を順に出力
  do i = 1, 10
     write(*,*) x(i)
  end do

  write(*,*) x                    ! 改行せずに1行に全要素を出力
  write(*,*) (y(i), i = 1, 10)    ! これも同じ
  write(*,*) (z(i), i = 1, 10, 2) ! 1つ飛ばしで出力

  stop
end program sample
