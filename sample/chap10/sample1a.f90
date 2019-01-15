module a
  use b
  implicit none

contains
  subroutine a_sub()
    implicit none

    call b_sub()
    write(*,*) 'a_sub in module a is called'
  end subroutine a_sub
end module a
