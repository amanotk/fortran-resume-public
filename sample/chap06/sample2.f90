program sample
  implicit none

  integer :: ios

  !
  ! ファイルを開く
  !
  ! unit     : 装置番号(ファイルを識別するための数値)
  ! iostat   : 正常時は0
  ! file     : ファイル名
  ! action   : 操作
  ! form     : formatted(アスキー形式) or unformatted(バイナリ形式)
  ! status   : new, old, replace
  ! position : rewind, append
  !

  ! * ファイルの新規作成(既に存在する場合はエラー)
  open(unit=10, iostat=ios, file='ascii.dat', action='write', &
       & form='formatted', status='new')

  ! * ファイルの新規作成(既に存在する場合は中身を破棄)
  !open(unit=10, iostat=ios, file='ascii.dat', action='write', &
  !     & form='formatted', status='replace')

  ! * 既に存在するファイルを開き, 位置をファイル終端に指定する(データの付け足し)
  !open(unit=10, iostat=ios, file='ascii.dat', action='write', &
  !     & form='formatted', status='old', position='append')

  ! ファイルが正常に開けたかどうかをチェックする
  if (ios /= 0) then
     write(*,*) 'Failed to open file for output'
     stop
  end if

  ! ファイルを閉じる
  close(10)

  !
  ! 既に存在するファイルを読み込み専用で開き, 位置をファイル先頭に指定する
  ! (ただしpositionは指定しなくても良い)
  !
  open(unit=20, iostat=ios, file='ascii.dat', action='read', &
       & form='formatted', status='old', position='rewind')

  ! またチェック
  if (ios /= 0) then
     write(*,*) 'Failed to open file for input'
     stop
  end if

  ! ファイルを閉じる
  close(20)

  stop
end program sample
