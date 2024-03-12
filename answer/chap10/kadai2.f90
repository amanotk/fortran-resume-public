! Newton法のモジュール
module mod_newton
  implicit none
  private

  integer, parameter :: default_maxit = 50
  real(8), parameter :: default_tol = 1.0e-8_8
  real(8), parameter :: epsilon = 1.0e-308_8

  ! オーバーロード
  interface newton
    module procedure newton_func, newton_sub
  endinterface newton

  public :: newton

contains
  ! Newton法 (fおよびdf/dxをそれぞれ返す関数を引数として受け取る)
  subroutine newton_func(f, df, x, error, status, maxit, tol)
    implicit none
    real(8), intent(inout) :: x
    real(8), intent(out) :: error
    integer, intent(out) :: status
    integer, intent(in), optional :: maxit
    real(8), intent(in), optional :: tol
    ! 引数としてサブルーチンを受け取る
    interface
      ! 関数値
      real(8) function f(x)
        real(8), intent(in) :: x
      endfunction f
      ! 微分値
      real(8) function df(x)
        real(8), intent(in) :: x
      endfunction df
    endinterface

    integer :: i, n
    real(8) :: dx, y, dy, tolerance

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

    status = 1
    do i = 1, n
      y = f(x)
      dy = df(x)
      dx = -y / (dy + epsilon)
      x = x + dx
      error = abs(dx)

      ! 収束判定
      if(error < tolerance) then
        status = 0
        exit
      endif
    enddo

    return
  endsubroutine newton_func

  ! Newton法 (fおよびdf/dxを返すサブルーチンを引数として受け取る)
  subroutine newton_sub(fdf, x, error, status, maxit, tol)
    implicit none
    real(8), intent(inout) :: x
    real(8), intent(out) :: error
    integer, intent(out) :: status
    integer, intent(in), optional :: maxit
    real(8), intent(in), optional :: tol
    ! 引数としてサブルーチンを受け取る
    interface
      subroutine fdf(x, f, df)
        real(8), intent(in) :: x
        real(8), intent(out) :: f, df
      endsubroutine fdf
    endinterface

    integer :: i, n
    real(8) :: dx, y, dy, tolerance

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

    status = 1
    do i = 1, n
      call fdf(x, y, dy)
      dx = -y / (dy + epsilon)
      x = x + dx
      error = abs(dx)

      ! 収束判定
      if(error < tolerance) then
        status = 0
        exit
      endif
    enddo

    return
  endsubroutine newton_sub

endmodule mod_newton

module mod_equation
  implicit none
contains
  ! 関数値
  function f(x) result(y)
    real(8), intent(in) :: x
    real(8) :: y

    y = x - cos(x)
  endfunction f

  ! 微分値
  function df(x) result(y)
    real(8), intent(in) :: x
    real(8) :: y

    y = 1 + sin(x)
  endfunction df

  ! サブルーチンで2つの値を同時に返す
  subroutine fdf(x, y, dy)
    implicit none
    real(8), intent(in) :: x
    real(8), intent(out) :: y, dy

    y = f(x)
    dy = df(x)

    return
  endsubroutine fdf
endmodule mod_equation

program answer
  use mod_newton
  use mod_equation
  implicit none

  integer :: status
  real(8) :: x, err

  x = 1.0

  ! 関数f, dfを引数として渡す
  call newton(f, df, x, err, status, 20, 1.0e-6_8)

  ! サブルーチンfdfを引数として渡す
  !call newton(fdf, x, err, status, 20, 1.0e-6_8)

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

  write(*, fmt='("Solution = ", e18.12, ", Error = ", e8.2)') x, err

  stop
endprogram answer
