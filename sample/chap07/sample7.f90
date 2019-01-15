program sample
  implicit none

  ! 16進数変換のためのテーブル (内部手続きからも参照される)
  character(len=1), parameter :: hex_char(0:15) = &
       & (/'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', &
       &   'A', 'B', 'C', 'D', 'E', 'F'/)

  integer :: n = 10
  character(len=8) :: hexstr

  ! どちらの n を参照するか？
  call sub()

  ! 整数を16進数に変換して表示
  n = 15*16**6 + 4*16**4 + 3*16**3 + 16**2 + 1
  call decimal2hex(n, hexstr)
  write(*,*) 'decimal = ', n, ' ===> hex = ', hexstr

  stop
contains
  !
  ! 内部手続きのスコープについて (1)
  !
  ! 内部手続きからはメインプログラムで宣言された変数を参照可能．ただし逆は不可．
  !
  ! nという名前の変数をサブルーチン内で宣言するかどうかで挙動が変わる
  subroutine sub()
    implicit none
    ! もし以下の行があればメインプログラムのnとサブプログラムのnは独立
    !integer :: n

    write(*,*) n        ! メインプログラム中の変数nにアクセス
  end subroutine sub

  !
  ! 内部手続きのスコープについて (2)
  !
  ! メインプログラムで定義された変数は内部手続きから参照出来るが，一般論としては
  ! 引数として渡すようにした方が安全である．以下の例のようにプログラム全体で共通
  ! に用いる定数であれば問題は起こらないことが多い．
  !
  ! 10進数を16進数に変換
  subroutine decimal2hex(decimal, hex)
    implicit none
    integer :: decimal
    character(len=*) :: hex

    integer :: i, n, d

    d = decimal
    do i = 1, 8
       n = d / 16**(8-i)
       d = d - n * 16**(8-i)
       ! メインプログラムで宣言された変数(hex_char)を参照
       hex(i:i) = hex_char(n)
    end do

  end subroutine decimal2hex

end program sample
