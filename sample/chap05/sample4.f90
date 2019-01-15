program sample
  implicit none

  integer :: i, j

  ! 2次元配列 (10 x 10 => 計100要素)
  real(8) :: a(10,10)

  ! 3次元配列 (4 x 8 x 16 => 計512要素)
  real(8) :: b(4, 8, 16)

  ! 動的配列も同様に宣言できる
  real(8), allocatable :: c(:,:)

  ! 動的配列: 4 x 8
  if( .not. allocated(c) ) then
     allocate(c(4,8))
  end if

  ! 配列に値を代入
  do j = 1, 4
     do i = 1, 8
        c(i,j) = i*j
     end do
  end do

  ! 配列の中身を表示
  do j = 1, 4
     do i = 1, 8
        write(*,*) c(i,j)
     end do
  end do

  deallocate(c)

  stop
end program sample
