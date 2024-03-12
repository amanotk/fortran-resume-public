module b
  implicit none

contains
  subroutine b_sub()
    implicit none

    write(*, *) 'b_sub in module b is called'
  endsubroutine b_sub
endmodule b
