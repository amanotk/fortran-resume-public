program sample
  implicit none

  ! 再帰呼び出し
  write(*, *) fact(2), fact(4), fact(6)

  stop
contains

  !
  ! <<< recursive (再帰的呼び出し) >>>
  !
  ! ちなみに以下の実装で正しい値が得られるのは n = 12 までである．なぜか？
  !
  recursive function fact(n) result(m) ! recursiveを指定する
    implicit none
    integer, intent(in) :: n
    integer :: m

    if(n == 1) then                    ! 無限ループにならないように
      m = 1
    else
      m = n * fact(n - 1)              ! 自分自身を(異なる引数で)呼び出す
    endif

  endfunction fact

endprogram sample
