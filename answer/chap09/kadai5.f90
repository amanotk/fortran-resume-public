module mod_rational
  implicit none
  private

  type :: rational
    integer :: num, den
  endtype rational

  interface operator(+)
    module procedure add
  endinterface operator(+)

  interface operator(-)
    module procedure sub
  endinterface operator(-)

  interface operator(*)
    module procedure mul
  endinterface operator(*)

  interface operator(/)
    module procedure div
  endinterface operator(/)

  interface assignment(=)
    module procedure assign
  endinterface assignment(=)

  public :: rational
  public :: show
  public :: operator(+), operator(-), operator(*), operator(/), assignment(=)

contains

  function add(a, b) result(ret)
    implicit none
    type(rational), intent(in) :: a, b
    type(rational) :: ret

    ret % num = a % num * b % den + a % den * b % num
    ret % den = a % den * b % den
    call reduction(ret % num, ret % den)

  endfunction add

  function sub(a, b) result(ret)
    implicit none
    type(rational), intent(in) :: a, b
    type(rational) :: ret

    ret % num = a % num * b % den - a % den * b % num
    ret % den = a % den * b % den
    call reduction(ret % num, ret % den)

  endfunction sub

  function mul(a, b) result(ret)
    implicit none
    type(rational), intent(in) :: a, b
    type(rational) :: ret

    ret % num = a % num * b % num
    ret % den = a % den * b % den
    call reduction(ret % num, ret % den)

  endfunction mul

  function div(a, b) result(ret)
    implicit none
    type(rational), intent(in) :: a, b
    type(rational) :: ret

    ret % num = a % num * b % den
    ret % den = a % den * b % num
    call reduction(ret % num, ret % den)

  endfunction div

  subroutine assign(a, b)
    implicit none
    type(rational), intent(out) :: a
    integer, intent(in) :: b(2)

    a % num = b(1)
    a % den = b(2)
    call reduction(a % num, a % den)

  endsubroutine assign

  subroutine show(r)
    implicit none
    type(rational), intent(in) :: r

    write(*, '(i6, " / ", i6)') r % num, r % den
    return
  endsubroutine show

  function gcd(a, b) result(ret)
    implicit none
    integer, intent(in) :: a, b
    integer :: ret

    integer :: r, m, n

    m = a
    n = b
    r = mod(m, n)
    do while(r /= 0)
      m = n
      n = r
      r = mod(m, n)
    enddo

    ret = abs(n)

  endfunction gcd

  subroutine reduction(num, den)
    implicit none
    integer, intent(inout) :: num, den

    integer :: r

    r = gcd(num, den)
    num = num / r
    den = den / r
  endsubroutine reduction

endmodule mod_rational

program answer
  use mod_rational
  implicit none

  type(rational) :: a, b

  a = (/1, 4/)
  b = (/2, 5/)

  write(*, fmt='(a)', advance='no') 'a     = '
  call show(a)

  write(*, fmt='(a)', advance='no') 'b     = '
  call show(b)

  write(*, fmt='(a)', advance='no') 'a + b = '
  call show(a + b)

  write(*, fmt='(a)', advance='no') 'a - b = '
  call show(a - b)

  write(*, fmt='(a)', advance='no') 'a * b = '
  call show(a * b)

  write(*, fmt='(a)', advance='no') 'a / b = '
  call show(a / b)

  stop
endprogram answer
