program sample
  implicit none

  write(*,*) 'square1 => ', square1(2.0_8)
  write(*,*) 'square2 => ', square2(2.0_8)

  ! 以下はエラー (引数はreal(8)で宣言されているのに与えられたのはreal(4))
  !write(*,*) square1(2.0), square2(2.0)

  stop
contains
  !!!!!!!!!! 関数やサブルーチンの宣言はここから !!!!!!!!!!

  !
  ! 関数の宣言(1) : 関数名と同じ名前の変数に返値を代入する形式
  !
  real(8) function square1(x)     ! square1という名前で関数を宣言
    implicit none                 ! 暗黙の型宣言の禁止
    real(8) :: x                  ! 引数を宣言

    square1 = x**2                ! 返値は関数名と同じ名前の変数に代入

    return                        ! 呼び出し元に制御を戻す
  end function square1

  !
  ! 関数の宣言(2) : resultを使った形式
  !
  function square2(x) result(y)   ! square2という名前で関数を宣言
    implicit none                 ! 暗黙の型宣言の禁止
    real(8) :: x                  ! 引数を宣言
    real(8) :: y                  ! 返値となる変数(result)の宣言

    y = x**2                      ! 返値を代入

    return                        ! 呼び出し元に制御を戻す
  end function square2

  !!!!!!!!!! ここまでの間に行う !!!!!!!!!!
end program sample
