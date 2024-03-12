program answer
  implicit none
  integer, parameter :: num_alphabet = 26
  integer, parameter :: upper_a = ichar('A')
  integer, parameter :: lower_a = ichar('a')
  integer, parameter :: upper_z = ichar('Z')
  integer, parameter :: lower_z = ichar('z')

  integer :: i, iostat
  integer :: hist(num_alphabet)
  character(len=256) :: text

  ! ヒストグラムを初期化
  hist = 0

  ! EOFまで読み続ける
  read(*, fmt='(a)', iostat=iostat) text
  do while(iostat == 0)
    call count_alphabet(text, hist)
    read(*, fmt='(a)', iostat=iostat) text
  enddo

  ! ヒストグラムを表示 (最大で60文字分)
  call print_histogram(hist, 60)

  stop
contains
  !
  ! 小文字のアルファベットを大文字に変換する
  !
  function toupper(ch) result(r)
    character, intent(in) :: ch
    character :: r

    integer :: ich

    ! デフォルト値
    r = ch

    ich = ichar(ch)
    if(ich >= lower_a .and. ich <= lower_z) then
      ! 文字コードが'a'以上'z'以下なら小文字なので大文字に変換する
      r = char(ichar(ch) - (lower_a - upper_a))
    endif

  endfunction toupper

  !
  ! 与えられた文字列に含まれるアルファベットの出現回数を調べる
  !
  subroutine count_alphabet(text, hist)
    implicit none
    character(*), intent(in) :: text
    integer, intent(out) :: hist(num_alphabet)

    integer :: i, ich, n

    n = len(text)
    do i = 1, n
      ich = ichar(toupper(text(i:i))) - upper_a + 1
      if(ich < 0 .or. ich > num_alphabet) then
        cycle ! A-Z 以外は無視
      endif
      hist(ich) = hist(ich) + 1
    enddo

  endsubroutine count_alphabet

  !
  ! ヒストグラムを出力
  !
  subroutine print_histogram(hist, hmax)
    implicit none
    integer, intent(in) :: hist(num_alphabet)
    integer, intent(in) :: hmax

    integer :: i, j
    real(8) :: norm
    character(len=128) :: str

    ! 文字数が多すぎる時はhmaxで規格化する
    if(maxval(hist) > hmax) then
      norm = real(hmax, 8) / real(maxval(hist), 8)
    else
      norm = 1.0_8
    endif

    do i = 1, num_alphabet
      ! ヒストグラムの長さの分だけ文字列を'o'で埋める
      str = ''
      do j = 1, nint(hist(i) * norm)
        str(j:j) = 'o'
      enddo
      ! 表示
      write(*, fmt='(a1, "(", i4, "):", a)') &
           & char(upper_a + i - 1), hist(i), trim(str)
    enddo

  endsubroutine print_histogram

endprogram answer
