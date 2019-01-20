program sample
  implicit none

  integer, pointer :: iptr
  integer, target  :: i, j

  integer :: lb(2), ub(2)
  integer, pointer :: rptr(:,:)
  integer, target :: x(9,9)

  i = 5
  j = 9

  ! 出力は iptr = 5, i = 5, j = 9
  iptr => i
  write(*,'(" iptr = ", i3, ", i = ", i3, ", j = ", i3)') iptr, i, j

  ! 出力は iptr = 9, i = 5, j = 9
  iptr => j
  write(*,'(" iptr = ", i3, ", i = ", i3, ", j = ", i3)') iptr, i, j

  ! 出力は iptr = 0, i = 5, j = 0
  iptr = 0
  write(*,'(" iptr = ", i3, ", i = ", i3, ", j = ", i3)') iptr, i, j

  ! 結合を解除
  if( associated(iptr) ) then
    nullify(iptr)
  end if

  ! 無名領域との結合
  allocate(iptr)
  iptr = 1

  ! 結合を解除
  deallocate(iptr)

  !
  ! 配列に対するポインタ
  !
  do j = 1, 9
     do i = 1, 9
        x(i,j) = i + (j-1)*9
     end do
  end do

  ! 部分配列へ結合
  rptr => x(2:4,2:6)

  lb = lbound(rptr) ! (/1, 1/)
  ub = ubound(rptr) ! (/3, 5/)

  write(*,*) '--- pointer array ---'
  do j = lb(2), ub(2)
     do i = lb(1), ub(1)
        write(*, fmt='(i7)', advance='no') rptr(i,j)
     end do
     write(*,*)
  end do

  ! targetを変更 => pointerにも反映される
  x(3,3) = -1.0

  write(*,*) '--- pointer array (modified) ---'
  do j = lb(2), ub(2)
     do i = lb(1), ub(1)
        write(*, fmt='(i7)', advance='no') rptr(i,j)
     end do
     write(*,*)
  end do

  ! 結合状態を解除
  nullify(rptr)

  ! pointerにメモリを割りつける(無名領域との結合)
  if (.not. associated(rptr) ) then
     allocate(rptr(9,9))
  end if

  ! この場合これはxの内容をrptrにコピー(=>と=の違いに注意)
  rptr = x

  ! これはpointerには反映されない
  x(3,3) = 0

  write(*,*) '--- allocated pointer array ---'
  do j = 1, 9
     do i = 1, 9
        write(*, fmt='(i7)', advance='no') rptr(i,j)
     end do
     write(*,*)
  end do

  deallocate(rptr)

  stop
end program sample
