! 物理定数モジュール
module mod_const
  implicit none
  private ! デフォルトで非公開

  ! 単位選択フラグ: 1 => MKS, 2 => CGS
  integer :: unit = 1

  real(8), parameter :: pi  = 4*atan(1.0_8)
  real(8), parameter :: mu0 = 4*pi * 1.0e-7_8

  ! MKS => CGS への変換ファクター
  real(8), parameter :: T = 1.0e+0_8
  real(8), parameter :: L = 1.0e+2_8
  real(8), parameter :: M = 1.0e+3_8

  ! MKSで定義
  real(8), parameter :: mks_light_speed       = 2.997924e+8_8
  real(8), parameter :: mks_electron_mass     = 9.109382e-31_8
  real(8), parameter :: mks_elementary_charge = 1.602176e-19_8

  ! これらのみ公開
  public :: set_mks, set_cgs
  public :: light_speed, electron_mass, elementary_charge

contains

  ! MKSモード
  subroutine set_mks()
    implicit none

    unit = 1
  end subroutine set_mks

  ! CGSモード
  subroutine set_cgs()
    implicit none

    unit = 2
  end subroutine set_cgs

  ! 光速
  function light_speed() result(x)
    implicit none
    real(8) :: x

    if( unit == 1 ) then
       x = mks_light_speed
    else if ( unit == 2 ) then
       x = mks_light_speed * L/T
    else
       call unit_error(unit)
    end if

  end function light_speed

  ! 電子質量
  function electron_mass() result(x)
    implicit none
    real(8) :: x

    if( unit == 1 ) then
       x = mks_electron_mass
    else if ( unit == 2 ) then
       x = mks_electron_mass * M
    else
       call unit_error(unit)
    end if

  end function electron_mass

  ! 素電荷
  function elementary_charge() result(x)
    implicit none
    real(8) :: x

    if( unit == 1 ) then
       x = mks_elementary_charge
    else if ( unit == 2 ) then
       x = mks_elementary_charge * light_speed() * sqrt(mu0/(4*pi) * M * L * T**2)
    else
       call unit_error(unit)
    end if

  end function elementary_charge

  ! エラー
  subroutine unit_error(u)
    implicit none
    integer, intent(in) :: u

    ! 標準エラー出力へ
    write(0,'(a, i3)') 'Error: invalid unit ', u

  end subroutine unit_error

end module mod_const

! メインプログラム
program sample
  use mod_const
  implicit none

  ! デフォルトはMKS
  write(*,'(a)') 'Physical Constants in MKS'
  write(*,'(a20, " : ", e12.4)') 'Elementary Charge', elementary_charge()
  write(*,'(a20, " : ", e12.4)') 'Electron Mass', electron_mass()
  write(*,'(a20, " : ", e12.4)') 'Speed of Light', light_speed()

  ! CGSで表示
  call set_cgs()
  write(*,'(a)') 'Physical Constants in CGS'
  write(*,'(a20, " : ", e12.4)') 'Elementary Charge', elementary_charge()
  write(*,'(a20, " : ", e12.4)') 'Electron Mass', electron_mass()
  write(*,'(a20, " : ", e12.4)') 'Speed of Light', light_speed()

end program sample
