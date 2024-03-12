program sample
  implicit none

  integer :: year

  ! 標準入力から整数を読み込む
  write(*, *) 'Input year: '
  read(*, *) year

  ! 基本的なifによる分岐
  if(mod(year, 400) == 0) then
    write(*, *) 'Leap year'
  else if(mod(year, 100) == 0) then
    write(*, *) 'Common year'
  else if(mod(year, 4) == 0) then
    write(*, *) 'Leap year'
  else
    write(*, *) 'Common year'
  endif

  ! 同じことを入れ子のifで実現
  if(mod(year, 4) == 0) then
    if(mod(year, 100) == 0) then
      if(mod(year, 400) == 0) then
        write(*, *) 'Leap year'
      else
        write(*, *) 'Common year'
      endif
    else
      write(*, *) 'Leap year'
    endif
  else
    write(*, *) 'Common year'
  endif

  stop
endprogram sample
