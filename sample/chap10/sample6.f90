program sample
  use mod_list
  implicit none

  type(list_type), pointer :: a

  nullify(a)

  write(*, fmt='(a20)', advance='no') 'initialize : '
  a = 1
  call show(a)

  write(*, fmt='(a20)', advance='no') 'append 2 : '
  call append(a, 2)
  call show(a)

  write(*, fmt='(a20)', advance='no') 'append 3 : '
  call append(a, 3)
  call show(a)

  write(*, fmt='(a20)', advance='no') 'insert -1 at 1 : '
  call insert(a, 1, -1)
  call show(a)

  write(*, fmt='(a20)', advance='no') 'insert -2 at 3 : '
  call insert(a, 3, -2)
  call show(a)

  write(*, fmt='(a20)', advance='no') 'remove at 1 : '
  call remove(a, 1)
  call show(a)

  write(*, fmt='(a20)', advance='no') 'remove at 3 : '
  call remove(a, 3)
  call show(a)

  write(*, fmt='(a20)', advance='no') 'delete : '
  call delete(a)
  call show(a)

  stop
endprogram sample
