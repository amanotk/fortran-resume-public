program answer
  implicit none

  integer :: i, l, m, n
  integer, allocatable :: array1d(:)
  integer, allocatable :: array3d(:,:,:)

  write(*,*) 'Input three positive integers (L, M, N) :'
  read(*,*) l, m, n

  allocate(array3d(l, m, n))
  allocate(array1d(l*m*n))

  write(*,*) '--- 3D array ---'
  write(*,*) 'size   (should be equal to L*M*N)               : ', size(array3d)
  write(*,*) 'shape  (should be equal to 1D array (/L, M, N/) : ', shape(array3d)
  write(*,*) 'lbound (should be equal to 1D array (/1, 1, 1/) : ', lbound(array3d)
  write(*,*) 'ubound (should be equal to 1D array (/L, M, N/) : ', ubound(array3d)

  write(*,*) '--- 1D array ---'
  write(*,*) 'size   (should be equal to L*M*N)               : ', size(array1d)
  write(*,*) 'shape  (should be equal to 1D array (/L*M*N/)   : ', shape(array1d)
  write(*,*) 'lbound (should be equal to 1D array (/1/)       : ', lbound(array1d)
  write(*,*) 'ubound (should be equal to 1D array (/L*M*N/)   : ', ubound(array1d)

  ! reshape and substiute into 1D array
  do i = 1, l*m*n
    array1d(i) = i
  end do
  array3d = reshape(array1d, (/l, m, n/))

  deallocate(array1d)
  deallocate(array3d)

  stop
end program answer
