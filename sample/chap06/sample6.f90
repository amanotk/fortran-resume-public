program sample
  implicit none

  integer, parameter :: max_line = 256
  integer :: ios, nline
  character(max_line) :: line

  nline = 0

  !
  ! fmt='(a)'  : 行末までを読み込むのに必要(途中のスペースで途切れないように)
  ! iostat=ios : ステータスがiosに代入される
  !
  read(*, fmt='(a)', iostat=ios) line

  !
  ! ios >  0 : 何らかのエラー
  ! ios == 0 : 正常に読み込まれた
  ! ios <  0 : ファイルの終端に達した
  !
  do while(ios == 0)
    ! 空白行以外をカウント(line == '' なら空白行である)
    if(line /= '') then
      nline = nline + 1
    endif
    ! 次の行を読み込む
    read(*, fmt='(a)', iostat=ios) line
  enddo

  write(*, *) 'Number of lines (without brank) : ', nline

  stop
endprogram sample
