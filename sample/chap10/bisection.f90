! 二分法のモジュール
module mod_bisection
  implicit none
  private

  integer, parameter :: default_maxit = 50
  real(8), parameter :: default_tol = 1.0e-8_8

  public :: bisection

contains
  ! 二分法により与えられた方程式の解を求める
  subroutine bisection(f, x1, x2, error, status, maxit, tol)
    implicit none
    real(8), intent(inout) :: x1, x2
    real(8), intent(out) :: error
    integer, intent(out) :: status
    integer, intent(in), optional :: maxit
    real(8), intent(in), optional :: tol
    ! 引数として関数を受け取る
    interface
      function f(x) result(y)
        real(8), intent(in) :: x
        real(8) :: y
      endfunction f
    endinterface

    integer :: i, n
    real(8) :: x, y, sig, tolerance

    ! 最大の反復回数
    if(.not. present(maxit)) then
      n = default_maxit
    else
      n = maxit
    endif

    ! 許容誤差
    if(.not. present(tol)) then
      tolerance = default_tol
    else
      tolerance = tol
    endif

    ! x1 < x2 とする
    if(x1 >= x2) then
      x = x1
      x1 = x2
      x2 = x1
    endif

    ! f(x1)とf(x2)の符号は逆
    if(f(x1) * f(x2) >= 0.0) then
      status = -1
      return
    endif

    status = 1
    sig = sign(1.0_8, f(x2) - f(x1))
    do i = 1, n
      x = (x1 + x2) * 0.5_8
      error = abs(x - x1)

      ! 収束判定
      if(error < tolerance) then
        status = 0
        exit
      endif

      ! 範囲を縮小
      y = f(x)
      if(y * sig < 0.0) then
        x1 = x
      else
        x2 = x
      endif
    enddo

    ! 最終的な根の近似値
    x1 = x
    return
  endsubroutine bisection

endmodule mod_bisection
