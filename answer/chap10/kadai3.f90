module mod_list
  implicit none
  private

  ! singly linked list
  type :: list_type
     type(list_type), pointer :: next
     integer :: value
  end type list_type

  interface append
     module procedure append_scalar, append_array
  end interface append

  interface insert
     module procedure insert_scalar, insert_array
  end interface insert

  interface assignment(=)
     module procedure assign_scalar, assign_array
  end interface assignment(=)

  public :: list_type
  public :: new, delete, show, append, insert, remove
  public :: assignment(=)

contains

  ! assignment (initialize list with a given value)
  subroutine assign_scalar(a, b)
    implicit none
    type(list_type), pointer, intent(out) :: a
    integer, intent(in) :: b

    call delete(a)
    call new(a, value=b)

  end subroutine assign_scalar

  ! assignment (initialize list with a given ue)
  subroutine assign_array(a, b)
    implicit none
    type(list_type), pointer, intent(out) :: a
    integer, intent(in) :: b(:)

    integer :: i

    call delete(a)
    call new(a, value=b(1))
    do i = 2, size(b)
       call append(a, b(i))
    end do

  end subroutine assign_array

  ! show list contents
  subroutine show(list)
    implicit none
    type(list_type), pointer, intent(in) :: list

    type(list_type), pointer :: iter

    write(*, fmt='("List = [")', advance='no')

    if( associated(list) ) then
       ! show contents
       iter => list
       write(*, fmt='(i5, x)', advance='no') iter%value
       do while( associated(iter%next) )
          iter => iter%next
          write(*,fmt='(i5, x)', advance='no') iter%value
       end do
    end if

    write(*, fmt='(a)') ']'

  end subroutine show

  ! create a new node (pointer must be initialized by nullify() in advance)
  subroutine new(list, next, value)
    implicit none
    type(list_type), pointer, intent(out) :: list
    type(list_type), pointer, optional, intent(in) :: next
    integer, optional, intent(in) :: value

    if( associated(list) ) then
       write(*,*) 'Error in new'
    end if

    allocate(list)
    nullify(list%next)

    if( present(next) ) then
       list%next => next
    end if

    if( present(value) ) then
       list%value = value
    end if

  end subroutine new

  ! safely delete all the list contents
  subroutine delete(list)
    implicit none
    type(list_type), pointer, intent(inout) :: list

    type(list_type), pointer :: iter, temp

    if( .not. associated(list) ) then
       return
    end if

    iter => list
    do while( associated(iter%next) )
       temp => iter
       iter => iter%next
       deallocate(temp)
    end do

    nullify(list)

  end subroutine delete

  ! return the last node
  function tail(list) result(iter)
    type(list_type), pointer, intent(in) :: list
    type(list_type), pointer :: iter

    iter => list
    do while( associated(iter%next) )
       iter => iter%next
    end do

  end function tail

  ! append a single node at the last
  subroutine append_scalar(list, value)
    implicit none
    type(list_type), pointer, intent(inout) :: list
    integer, intent(in) :: value

    type(list_type), pointer :: iter

    iter => tail(list)
    call new(iter%next, value=value)

  end subroutine append_scalar

  ! append an array at the last
  subroutine append_array(list, array)
    implicit none
    type(list_type), pointer, intent(inout) :: list
    integer, intent(in) :: array(:)

    integer :: i
    type(list_type), pointer :: iter


    iter => tail(list)
    do i = 1, size(array)
       call new(iter%next, value=array(i))
       iter => iter%next
    end do

  end subroutine append_array

  ! insert a node at a given index
  subroutine insert_scalar(list, index, value)
    implicit none
    type(list_type), pointer, intent(inout) :: list
    integer, intent(in) :: index
    integer, intent(in) :: value

    integer :: i
    type(list_type), pointer :: iter, prev, node

    if( index < 1 ) then
       write(*,*) 'Error: no such node'
       return
    end if

    ! find a node after which a new node is inserted
    nullify(prev)
    iter => list
    do i = 1, index-1
       if( .not. associated(iter%next) ) then
          write(*,*) 'Error: no such node'
          return
       end if
       prev => iter
       iter => iter%next
    end do

    ! create a new node
    nullify(node)
    call new(node, next=iter, value=value)

    if( .not. associated(prev) ) then ! first node
       list => node
    else
       prev%next => node
    end if

  end subroutine insert_scalar

  ! insert an array at a given index
  subroutine insert_array(list, index, array)
    implicit none
    type(list_type), pointer, intent(inout) :: list
    integer, intent(in) :: index
    integer, intent(in) :: array(:)

    integer :: i
    type(list_type), pointer :: iter, next, prev, temp

    if( index < 1 ) then
       write(*,*) 'Error: no such node'
       return
    end if

    ! find a node after which a new node is inserted
    nullify(prev)
    iter => list
    do i = 1, index-1
       if( .not. associated(iter%next) ) then
          write(*,*) 'Error: no such node'
          return
       end if
       prev => iter
       iter => iter%next
    end do
    next => iter

    ! create a new list
    nullify(temp)
    temp = array
    if( .not. associated(prev) ) then ! first node
       list => temp
    else
       prev%next => temp
    end if
    iter => tail(temp)
    iter%next => next

  end subroutine insert_array

  ! remove a node at a given index
  subroutine remove(list, index)
    implicit none
    type(list_type), pointer, intent(inout) :: list
    integer, intent(in) :: index

    integer :: i
    type(list_type), pointer :: iter, prev

    if( index < 1  ) then
       write(*,*) 'Error: no such node'
    end if

    ! find a node to be removed
    nullify(prev)
    iter => list
    do i = 1, index-1
       if( .not. associated(iter%next) ) then
          write(*,*) 'Error: no such node'
          return
       end if
       prev => iter
       iter => iter%next
    end do

    if( .not. associated(prev) ) then ! first node
       list => list%next
    else
       prev%next => iter%next
    end if

    deallocate(iter)

  end subroutine remove

end module mod_list

program answer
  use mod_list
  implicit none

  type(list_type), pointer :: a

  nullify(a)

  write(*, fmt='(a25)', advance='no') 'assignment : '
  a = (/0, 1, 2/)
  call show(a)

  write(*, fmt='(a25)', advance='no') 'append scalar : '
  call append(a, 3)
  call show(a)

  write(*, fmt='(a25)', advance='no') 'append array : '
  call append(a, (/4, 5/))
  call show(a)

  write(*, fmt='(a25)', advance='no') 'insert scalar at 1 : '
  call insert(a, 1, -1)
  call show(a)

  write(*, fmt='(a25)', advance='no') 'insert array at 1 : '
  call insert(a, 1, (/-3, -2/))
  call show(a)

  write(*, fmt='(a25)', advance='no') 'delete : '
  call delete(a)
  call show(a)

end program answer
