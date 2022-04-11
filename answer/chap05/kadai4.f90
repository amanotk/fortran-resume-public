program answer
  implicit none

  real(8), allocatable :: vector1(:), vector2(:)
  integer :: i, n
  real(8) :: dot1, dot2

  read(*,*) n

  allocate(vector1(n))
  allocate(vector2(n))

  read(*,*) vector1
  read(*,*) vector2

  dot1 = 0.0_8
  do i = 1, n
     dot1 = dot1 + vector1(i)*vector2(i)
  end do

  dot2 = dot_product(vector1, vector2)

  write(*,*) 'Inner product with do loop     : ', dot1
  write(*,*) 'Inner product with dot_product : ', dot2

  deallocate(vector1)
  deallocate(vector2)

  stop
end program answer
