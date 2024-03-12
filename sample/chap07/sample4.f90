program sample
  implicit none

  integer :: i
  real(8) :: a, b, c
  real(8) :: x(10)

  do i = 1, 10
    x(i) = real(i, 8)
  enddo

  ! intent属性
  a = 1.0
  b = 2.0
  call add(a, b, c)
  write(*, *) a, b, c

  ! 配列の渡し方
  write(*, *) 'average ===> ', average1(x), average2(10, x)

  ! save属性の使い方
  do i = 1, 10
    call fibonacci()
  enddo

  stop
contains

  !
  ! <<< intent属性 >>>
  !
  ! * intent(in)    => 入力用変数(値の変更不可)
  ! * intent(out)   => 出力用変数
  ! * intent(inout) => 入出力
  !
  ! 以下は
  !
  ! c = a + b
  !
  ! のような処理を行うことを意図している．ユーザーはこの場合にaやbが変更されると
  ! は予想しないであろう．誤ってサブルーチン内でaやbの値を変更するのを防ぐために
  ! intent(in)を指定する．
  !
  subroutine add(a, b, c)
    implicit none
    real(8), intent(in) :: a, b       ! 入力用変数(変更不可)
    real(8), intent(out) :: c         ! 出力用変数

    ! 以下はコンパイルエラー
    !a = 1.0_8

    ! 出力用の変数に値を代入
    c = a + b

  endsubroutine add

  !
  ! <<< 形状引継ぎ配列の使い方 >>>
  !
  ! 引数の配列のサイズは自動的に呼出し時に与えた配列のサイズになる
  ! サイズが必要な場合は組み込み関数sizeを用いて取得可能
  !
  function average1(x) result(ave)
    implicit none
    real(8), intent(in) :: x(:)        ! サイズは自動的に決まる
    real(8) :: ave

    ave = sum(x) / size(x)

  endfunction average1

  !
  ! <<< 配列サイズの引数渡し >>>
  !
  ! 配列のサイズを引数として明示的に受け取る
  !
  function average2(n, x) result(ave)
    implicit none
    integer, intent(in) :: n           ! サイズを引数として受け取る
    real(8), intent(in) :: x(n)        ! サイズは引数として渡された整数
    real(8) :: ave

    ave = sum(x) / size(x)

  endfunction average2

  !
  ! <<< save属性 >>>
  !
  ! save属性付きの変数はプログラム実行中はその値を保持するので，複数回呼び出され
  ! た場合には前回の呼出し時の値を記憶したままとなる
  !
  subroutine fibonacci()
    implicit none
    ! 以下の3つがsave属性付き (初回の呼出し時の値は宣言文で与える)
    integer, save :: n = 1
    integer, save :: f0 = 0
    integer, save :: f1 = 0

    integer :: f2

    if(n == 1) then
      write(*, *) 'Fibonacci number [', 0, '] = ', f0
      f2 = 1
    else
      f2 = f0 + f1
    endif

    write(*, *) 'Fibonacci number [', n, '] = ', f2

    ! 次回呼び出し用 (これらの値を記憶し続ける)
    n = n + 1
    f0 = f1
    f1 = f2

  endsubroutine fibonacci

endprogram sample
