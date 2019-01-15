module b
  implicit none

contains
  subroutine b_sub()
    implicit none

    write(*,*) 'b_sub in module b is called'
  end subroutine b_sub
end module b
