program sample
  implicit none

  call hello('Michel')

  stop
contains
  !!!!!!!!!! 関数やサブルーチンの宣言はここから !!!!!!!!!!

  !
  ! サブルーチンの宣言
  !
  subroutine hello(name)          ! helloという名前でサブルーチンを宣言
    implicit none                 ! 暗黙の型宣言の禁止
    character(len=*) :: name      ! 引数を宣言 (任意長の文字列)

    write(*, *) 'Hello ', name    ! 内部の処理

    return
  endsubroutine hello

  !!!!!!!!!! ここまでの間に行う !!!!!!!!!!
endprogram sample
