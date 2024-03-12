program sample
  implicit none

  ! optional属性付きの引数は省略可能
  call hello('Michael')             ! 標準出力へ
  call hello('Jackson', 0)          ! 標準エラー出力へ

  ! キーワード引数の使い方 (1)
  ! 引数の順序は気にしなくて良い
  ! optional引数がある場合はoptional引数は省略可能
  call hello(unit=0, name='Albert') ! 標準エラー出力へ
  call hello(name='Einstein')       ! 標準出力へ

  ! キーワード引数の使い方 (2)
  ! optional引数が無い場合でもキーワード引数を用いた呼出しは出来る．
  ! この場合も引数の順序は気にしなくて良いが全ての引数が必須
  call chao(unit=0, name='Enrico')  ! 標準エラー出力へ
  call chao(name='Fermi', unit=6)   ! 標準出力へ

  stop
contains

  !
  ! <<< optional属性 >>>
  !
  ! optional属性付きの引数は呼出し時に与えなくても良い．与えられなかった場合のデ
  ! フォルトの振る舞いはユーザーの責任で実装しなければならない．
  ! 以下では出力先を引数で与える装置番号にするか，デフォルトの標準出力にするかを
  ! 選択することが出来る．
  !
  subroutine hello(name, unit)
    implicit none
    character(len=*), intent(in) :: name
    integer, intent(in), optional :: unit    ! optional属性付き引数

    integer :: u

    ! 組込み関数presentで引数が呼出し時に指定されたかどうかを調べることが出来る．
    ! 返値が真なら指定有り，偽なら指定無し (偽の場合はデフォルトの動作を実装)
    if(present(unit)) then
      u = unit                              ! unitを指定
    else
      u = 6                                 ! デフォルトは標準出力
    endif

    write(u, *) 'Hello ', name              ! 表示

    return
  endsubroutine hello

  !
  ! これでもキーワード引数を使うことは出来る
  !
  subroutine chao(name, unit)
    implicit none
    character(len=*), intent(in) :: name
    integer, intent(in) :: unit

    write(unit, *) 'Chao ', name

    return
  endsubroutine chao

endprogram sample
