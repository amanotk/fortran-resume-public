! モジュールの定義
module mod_variable
  implicit none

  ! 定数の定義
  real(8), parameter :: light_speed = 2.998e+08 ! 光速 [m/s]
  real(8), parameter :: kboltzmann  = 1.381e-23 ! Boltzmann定数 [J/K]
  real(8), parameter :: hplanck     = 6.626e-34 ! Planck定数 [J s]

  ! 変数
  real(8), save :: x, y, z

end module mod_variable

! メインプログラム
program sample
  use mod_variable
  implicit none

  ! 定数の値は参照のみ可能
  write(*, '(a20, ":", e12.4)') 'speed of light', light_speed
  write(*, '(a20, ":", e12.4)') 'Boltzmann constant', kboltzmann
  write(*, '(a20, ":", e12.4)') 'Planck constant', hplanck

  ! これはできない(コンパイルエラー)
  !light_speed = 1.0_8

  ! 変数の値は変更可能
  x = 1.0
  y = 0.0
  z = 0.0

  stop
end program sample
