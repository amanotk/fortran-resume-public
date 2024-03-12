program sample
  implicit none

  integer, parameter :: n = 5
  integer :: i, j
  real(8) :: a(n, n), b(n), x(n)
  real(8) :: inner

  x = (/1.0_8, 0.5_8, 0.0_8, 0.5_8, 1.0_8/)

  a = reshape( &
       & (/-2.0, 1.0, 0.0, 0.0, 0.0, &
       &    1.0, -2.0, 1.0, 0.0, 0.0, &
       &    0.0, 1.0, -2.0, 1.0, 0.0, &
       &    0.0, 0.0, 1.0, -2.0, 1.0, &
       &    1.0, 0.0, 0.0, 1.0, -2.0/), &
       & (/n, n/))

  ! 配列aの形状およびサイズを表示
  write(*, *) 'shape of a = ', shape(a)
  write(*, *) 'size of a = ', size(a)

  ! 初期化
  do i = 1, n
    b(i) = 0.0_8
  enddo

  ! 行列aとベクトルxの積をbに代入: b_{i} = a_{i,j} * x_{j}
  do j = 1, n
    do i = 1, n
      b(i) = b(i) + a(i, j) * x(j)
    enddo
  enddo

  write(*, *) 'b = ', b

  ! 組み込み関数を使用して同じ計算を行う
  b = matmul(a, x)

  write(*, *) 'b = ', b

  ! ベクトル同士の内積を計算
  inner = 0.0_8
  do i = 1, n
    inner = inner + b(i) * x(i)
  enddo

  write(*, *) 'inner product 1 = ', inner

  ! 組み込み関数を使用して同じ計算を行う
  inner = dot_product(b, x)

  write(*, *) 'inner product 2 = ', inner

  stop
endprogram sample
