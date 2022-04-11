program answer
  implicit none

  real(8), allocatable :: vector1(:), vector2(:), vector3(:), matrix(:,:)
  integer :: i, j, n

  read(*,*) n

  allocate(vector1(n))
  allocate(vector2(n))
  allocate(vector3(n))
  allocate(matrix(n, n))

  read(*,*) vector1
  read(*,*) matrix
  matrix = transpose(matrix)

  vector2 = 0.0_8
  do j = 1, n
     do i = 1, n
        vector2(i) = vector2(i) + matrix(i,j)*vector1(j)
     end do
  end do

  vector3 = matmul(matrix, vector1)

  write(*,*) 'Matrix-vector product with do loop'
  do i = 1, n
     write(*,*) vector2(i)
  end do

  write(*,*) 'Matrix-vector product with matmul'
  do i = 1, n
     write(*,*) vector3(i)
  end do

  deallocate(vector1)
  deallocate(vector2)
  deallocate(vector3)
  deallocate(matrix)

  stop
end program answer
