#ifdef _DEBUG
#define DEBUG_PRINT(a) write(*,*) (a)
#else
#define DEBUG_PRINT(a)
#endif

program sample
  implicit none

  integer :: i

#if 1
  write(*,*) 'hello A'
#else
  write(*,*) 'hello B'
#endif

  i = 2015
  DEBUG_PRINT('This will be shown only when _DEBUG is defined.')
  DEBUG_PRINT(i)

  stop
end program sample
