program sample
  implicit none

  call sub1(4.0_8)
  call sub2()

  stop
contains
  ! sub1
  subroutine sub1(exponent)
    implicit none
    real(8) :: exponent

    !
    ! 基本的に内部でのみ使う変数はここで宣言して使う
    ! 特にループ変数(以下の例ではi)は必須
    ! これらの変数は外部からは見えないので，メインプログラムや他のサブプログラム
    ! で同名の変数が宣言されていてもそれらとは完全に独立であることに注意
    !
    ! (引数に値を代入して返す場合，メインプログラムの変数を参照する場合について
    ! はレジュメのintent属性や内部手続きの節を参照のこと)
    !
    integer, parameter :: n = 10
    integer :: i
    real(8) :: x(n), sum

    ! 代入
    do i = 1, n
      x(i) = i**exponent
    enddo

    ! 和を計算
    sum = 0.0_8
    do i = 1, n
      sum = sum + x(i)
    enddo

    write(*, *) 'sum of array = ', sum

  endsubroutine sub1

  ! sub2
  subroutine sub2()
    implicit none

    ! このように定義されていても問題無い(sub1のnとは独立な変数である)
    integer, parameter :: n = 100

    write(*, *) 'n = ', n

  endsubroutine sub2

endprogram sample
