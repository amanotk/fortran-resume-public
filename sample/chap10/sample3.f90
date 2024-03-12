! <<< 注意 >>>
! gfortran-4.3でコンパイルするためには内部手続きとして定義した関数はbisectionに渡
! せない. ifortやgfortran-4.6ではちゃんとコンパイルできるが, 可搬性を考慮して関数
! を別モジュール内で定義して用いることにする.
module mod_equation
  implicit none
contains
  ! 方程式
  function f(x) result(ret)
    implicit none
    real(8), intent(in) :: x
    real(8) :: ret

    ret = x - cos(x)

    return
  endfunction f
endmodule mod_equation

! 関数やサブルーチンの引数渡し
program sample
  use mod_bisection
  use mod_equation
  implicit none

  integer :: status
  real(8) :: x1, x2, err

  ! 二分法で方程式の解を求める(関数fを引数として渡す)
  x1 = 0.0
  x2 = 1.0
  call bisection(f, x1, x2, err, status, maxit=20, tol=1.0e-6_8)

  select case(status)
  case(0)
    write(*, fmt='(a)') 'Iteration converged !'
  case(1)
    write(*, fmt='(a)') 'Iteration did not converge !'
  case(-1)
    write(*, fmt='(a)') 'Error'
    stop
  case default
    write(*, fmt='(a)') 'Unknown error'
    stop
  endselect

  write(*, fmt='("Solution = ", e18.12, ", Error = ", e8.2)') x1, err

  stop
endprogram sample
