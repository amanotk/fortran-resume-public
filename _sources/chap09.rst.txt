.. -*- coding: utf-8 -*-

.. highlight:: fortran
  :linenothreshold: 1

==================
モジュールと構造型
==================

これまでに既に :ref:`c7` ではプログラムの開発を容易にするための手段として，関数やサブルーチンといったサブプログラムを用いる方法を学んだ．これらサブプログラムは機能を分割し，1つの独立したプログラム単位として扱われる．ところがプログラムの規模が大きくなってくると，関数やサブルーチン群を用いるだけでは必ずしも十分とは言えなくなって来る．そのような場合に便利になってくる **モジュール** という機能について学ぼう．

モジュールも独立したサブプログラムであるが，関数やサブルーチンなどよりも **1段階大きなプログラム単位** として考えることができる．すなわち，複数の関連する機能を提供する関数やサブルーチン群を1つのモジュールにまとめて提供することが出来る．さらに関数やサブルーチンと大きく異なり，モジュール内部に宣言された変数に外部からアクセスすることも出来るため，複数の変数群をまとめる役割も果たす．またモジュールと共に用いると便利な **構造型** の使い方も身につけよう．構造型はいくつかのデータを1つにまとめて，新しいユーザー定義型を提供する機能である．

    サンプルプログラム

    - :doc:`sample1.f90 <chap09_sample1_f90>` : 定数や変数の参照
    - :doc:`sample2.f90 <chap09_sample2_f90>` : 内部手続き
    - :doc:`sample3.f90 <chap09_sample3_f90>` : 総称名
    - :doc:`sample4.f90 <chap09_sample4_f90>` : アクセス制限
    - :doc:`sample5.f90 <chap09_sample5_f90>` : 構造型と演算子オーバーロード

.. contents:: この章の内容
    :depth: 2

モジュールの基本
================

既に述べたようにモジュールは1つの独立したプログラム単位である．その特徴は以下の様な点である．

-  モジュール内で変数宣言が出来る．宣言された変数はモジュール内部からはもちろん他のモジュールやメインプログラムから使用することが出来る．
-  複数の関数やサブルーチンをモジュール内で内部手続きとして定義することが出来る．内部手続きはモジュール内部の他の内部手続きや，モジュール外部から呼び出すことも出来る．

モジュールの定義は以下のような形で行う．

::

    module name_of_module
      implicit none

      ! 変数宣言など

    contains

      ! 内部手続きの定義

    end module name_of_module

モジュールの構造はメインプログラムと非常に似ており，``module`` で始まり，``end module`` で終わる．また内部手続きは ``contains`` から ``end module`` の間に定義する．ただしメインプログラムに記述されたコードは上から順に実行されていくのに対して，モジュール内( ``implicit none`` から ``contains`` までの間)には実行文は記述せず，変数宣言などを行うだけである．内部手続きについても明示的に呼び出されない限りは実行されることは無い．

定義したモジュールはメインプログラムや，サブルーチン，関数，または他のモジュールから参照して用いることが出来る．使い方は ``implicit none`` を記述する前に ``use`` によって使いたいモジュールを記述するだけである．

例えばメインプログラムからモジュールを使用するには

::

    program name_of_program
      use name_of_module
      implicit none

      ! メインプログラムの処理

    end program name_of_program

というような形となる．

.. _c9_refer_variables:

変数や定数の参照
================

    :doc:`サンプルコード参照 <chap09_sample1_f90>`

モジュールを用いると変数や定数の宣言を共通化し，異なるモジュールやメインプログラムから利用することが出来る．大規模プログラムで共通の変数が複数のモジュールなどから参照される場合には変数宣言を共通化しておくと良い．具体的には以下の例の様になる．

::

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

プログラム実行中に常にどこからでもアクセスできる変数を **グローバル変数**，サブルーチンや関数の内部でしか用いない変数を **ローカル変数** などと呼ぶことがある．上の例ではモジュールの内部変数がグローバル変数として用いられている．この例のように，一般にはモジュール変数をグローバル変数として用いるには ``save`` 属性を付けておく方が良い．例えば上の例で変数 ``x``，``y``，``z`` の宣言を

::

      real(8) :: x, y, z

としてしまうと，複数のサブルーチンや関数などから ``use`` で参照される場合に，その都度これらの値が書き換えられてしまう(初期化される)可能性がある．(例えばメインプログラムから1度だけ ``use`` で参照される場合にはこのような問題は生じない．) 最近のコンパイラは自動でモジュール内変数に ``save`` 属性が指定されたものと扱う場合が多いようなので，これは必ずしも必須ではないかもしれない．ただしコンパイラ依存性を無くし，移植性の高いプログラムとするためには指定しておいた方が無難であろう．なお，いずれにせよ定数変数については参照されるだけなので ``save`` 属性は必要ない．

一般に，プログラムが複雑化して来ると **グローバル変数がバグの原因** になりやすくなるため，使わない方が良いとされている．グローバル変数を一切使わない場合にはメインプログラムで全ての変数を宣言し，必要な変数を各サブルーチンや関数へ全て引数として渡せば良い．この場合にはデータの受け渡しが明示的に行われるので，意図せずデータが変更されるのを防ぐことが出来る．ただしこれはあくまで一般論であり，いつでもグローバル変数の使用を避けるべきというわけではない．比較的単純で，データの受け渡しを間違いそうに無いようなプログラム(比較的小規模の数値シミュレーションコードはこれに当てはまる場合が多い)であればグローバル変数を用いた方がスッキリ書けるような場合も多い．ただし，この場合でもグローバル変数にしても問題無い変数と，ローカル変数にすべき変数はよく考えて区別しておいた方が良い．何でもかんでもグローバル変数にしてしまうと汎用性の無いプログラムになってしまい，仕様変更に伴うプログラムの修正が非常に困難になる．

例えば以下の例を考えよう．ここでは変数 ``i`` をモジュール ``mod_global`` 内で定義されたグローバル変数として用いている．メインプログラムの内部手続きとして定義されたサブルーチン ``sub`` 内の ``do`` ループでも，メインプログラムでも変数 ``i`` をループ変数として用いている．``gfortran`` でこのプログラムをコンパイルして実行すると，無限ループになってしまうようである(この動作はコンパイラに依存するかもしれないが，いずれにせよ「意図した通り」には動かない)．これはメインプログラムから ``sub`` を3回呼び出すつもりでも，``sub`` 内部で変数 ``i`` の値が更新され，メインプログラムの ``do`` ループの反復が正しく終了しないためであろう．これは極端な例ではあるが，特にループ変数のように不用意に使ってしまいそうな名前の変数はローカル変数にして，必要な場合にその都度宣言して用いる方が安全である．

::

    module mod_global
      implicit none

      ! グローバル変数
      integer, save :: i

    end module mod_global

    program main
      use mod_global
      implicit none

      ! グローバル変数iでループを回す
      do i = 1, 2
         call sub() ! この中でiが更新されてしまう!!
      end do

      stop
    contains
      subroutine sub()
        implicit none

        ! ここでもグローバル変数iでループを回す
        do i = 1, 3
           write(*,*) i
        end do

      end subroutine sub
    end program main

.. _c9_internal_procedure:

内部手続き
==========

    :doc:`サンプルコード参照 <chap09_sample2_f90>`

メインプログラムと同様に，モジュールにも内部手続きを定義することが可能であり，またモジュールの内部手続きからモジュール内で定義された変数には自由にアクセスすることが出来る(これもメインプログラムの内部手続きと同様である)．``use`` でモジュールの使用を宣言すると，モジュールの変数だけでなく内部手続きも同様に用いることが出来る．このようにモジュールは関連する変数と手続きをまとめることが出来るため，サブルーチンや関数よりも大きなプログラム単位を提供することになる．

例えば以下のモジュール ``mod_integrator`` は予めサンプリングされた関数値の配列と刻み幅を受け取り，:ref:`c8_numerical_integration` で扱った台形公式およびSimpsonの公式を用いて数値積分する関数を内部手続きとして実装したモジュールである．このように関連するサブプログラムをまとめてモジュールの内部手続きとして実装しておけば，``use mod_integrator`` するだけで(外部手続きの時のように ``interface`` による準備をしなくても)安全に利用することが出来る．これから分かるように，:ref:`c9_internal_procedure` で外部手続きを非推奨としたのは，単純に外部手続きを何らかのモジュールの中に入れて(内部手続きとして定義して)しまえば良いからである．これによって外部手続きの抱える問題は全て解決する．

::

    module mod_integrator
      implicit none

    contains
      !
      ! 台形公式による数値積分
      !
      function trapezoid(f, dx) result(ret)
        implicit none
        real(8), intent(in) :: f(:)
        real(8), intent(in) :: dx
        real(8) :: ret

        integer :: i, n

        n = size(f)

        ret = 0.5_8 * (f(1) + f(n))
        do i = 2, n-1
           ret = ret + f(i)
        end do
        ret = ret * dx

      end function trapezoid

      !
      ! Simpson公式による数値積分
      !
      function simpson(f, dx) result(ret)
        implicit none
        real(8), intent(in) :: f(:)
        real(8), intent(in) :: dx
        real(8) :: ret

        integer :: i, n

        n = size(f)

        ! 端点を含めた配列サイズが奇数でなければエラー
        if( mod(n, 2) == 0 ) then
           write(*,*) 'array size must be odd'
           stop
        end if

        ret = f(1) + f(n)
        ! even
        do i = 2, n-1, 2
           ret = ret + 4.0_8 * f(i)
        end do
        ! odd
        do i = 3, n-2, 2
           ret = ret + 2.0_8 * f(i)
        end do
        ret = ret * dx / 3.0_8

      end function simpson
    end module mod_integrator

総称名
======

    :doc:`サンプルコード参照 <chap09_sample3_f90>`

これまでは何も意識せずに単精度で宣言された ``x`` に対しても，倍精度で宣言された ``x`` に対しても ``sin(x)`` のように型の精度を気にせず組み込み関数を呼び出しをしてきたことと思う．しかし自分で定義した関数やサブルーチンについては，正確に宣言した型を引数として呼び出す必要があった．実はその昔のFortran 77の時代には単精度に対して ``sin(x)``，倍精度に対しては ``dsin(x)`` というように，組み込み関数にも精度ごとに異なる関数が用意されていて，手動で使い分ける必要があった(ここで ``d`` は倍精度を表すdoubleの意味である)．これでは明らかに不便である．

Fortran 90以降では，この問題を解決するために，内部手続きに対して総称名(オーバーロード)という便利な機能を用いることが出来るようになった [#]_．これを用いると，呼び出し形式(引数の数や型)が異なる複数の関数やサブルーチンを同じ名前で呼び出すことが出来る．先ほどの ``sin(x)`` の例で言えば，引数 ``x`` が単精度実数であれば単精度版を，倍精度であれば倍精度版の関数を自動的に選択して呼び出すことになる．自分で定義した関数やサブルーチンについても，この総称名の機能を用いることが出来る．

これにはモジュールの変数宣言部分で

::

      interface generic_procedure
        module procedure specific_procedure1, specific_procedure2
      end interface generic_procedure

のように ``interface`` を用いて総称名を宣言すれば良い．個別名としては呼び出し形式の異なる(形式が同じだとコンパイラが判別出来ない!)複数の関数やサブルーチンをカンマで区切って記述する．これによって複数のルーチンを単一の名前で呼び出すことが出来る．(上の例の場合は総称名 ``generic_procedure`` によって ``specific_procedure1`` や ``specific_procedure2`` を呼び出す．)コンパイラは総称名で呼び出されたルーチンについて，その呼び出し形式に応じて自動的に適切なものを選択する．具体的な使い方は以下の例を見て欲しい．

::

   ! 面積を計算するモジュール
   module mod_area
     implicit none

     real(8), parameter :: pi = 4*atan(1.0_8)

     ! 総称名を定義
     interface triangle
        module procedure triangle1, triangle2
     end interface triangle

   contains

     ! 底辺と高さが与えられた時の面積の計算
     function triangle1(a, b) result(area)
       real(8), intent(in) :: a, b
       real(8) :: area

       area = a * b / 2

     end function triangle1

     ! 3つの頂点の座標が与えられた時の面積の計算
     function triangle2(x1, y1, x2, y2, x3, y3) result(area)
       real(8), intent(in) :: x1, y1, x2, y2, x3, y3
       real(8) :: area

       area = abs((x2-x1)*(y3-y1) - (x3-x1)*(y2-y1))/2

     end function triangle2

   end module mod_area

この例では三角形の面積を底辺と高さが与えられた時と3つの頂点の座標が与えられた時のいずれも同じ関数名で呼び出すことが出来るように総称名 ``triangle`` を宣言している．2つの違いは呼び出し時の引数だけなので，呼び出される時の引数の個数や型によってコンパイラが自動的に適切な方を呼び出すことが出来る．なお，総称名を用いると全く別の機能を実装したものであってもまとめることが出来てしまうのだが，このような使い方は混乱の元になるだけであろう．総称名を使うのは意味的に同じ機能を持った関数やサブルーチンをまとめる時にのみにしておいた方が良い．

アクセス制限
============

    :doc:`サンプルコード参照 <chap09_sample4_f90>`

モジュールを用いるために ``use`` すると，モジュール内で定義された変数，関数，サブルーチンに自由にアクセスできるが，これは一般的にはあまり好ましいことでは無い．例えば，:ref:`c9_refer_variables` では不用意にグローバル変数を作るとバグの元になることを示した．これはモジュールの利用者がモジュール内部の詳細を知らないために起こる問題である．

しかし，そもそもモジュールを利用する側はモジュール内部の詳細について知らないことが一般的であるし，そうあってしかるべきである．すなわち，モジュールを提供する側はそのモジュールと外部のインターフェースのみを提供し，内部の実装の詳細については公開しないという立場を取る方が懸命である．これには主に以下の2つの理由が挙げられる．

-  モジュールを利用する立場からは，モジュール内で定義された変数名などで名前空間が汚染されてしまい，同じ名前の変数やルーチンを宣言出来なくなる．
-  モジュールを提供する立場からは，モジュール内部で用いている変数などが不用意に変更されてしまう可能性がある．例えば何らかの状態を保持する変数が利用者から意図せず変更されてしまうと動作がおかしくなるかもしれない．

:ref:`c7` で学んだことは，それらをブラックボックスとして用いることで間違いを減らすことが出来るということであった．モジュールについても基本的に考え方は同じであって，せっかく機能を分割してモジュールを実装したのならば利用する時にはその中身のことは忘れたい．特に規模が大きなプログラムを複数人体制で開発する際には他人が実装したモジュールの中身など知る由も無いし，知りたくも無いであろう．いたずらに守備範囲を広げてエラーするくらいなら，狭くても良いから自分の守備範囲だけは死守する方が守りは固くなるのである．

参照先からのアクセス制限
------------------------

まずは参照先(モジュールの利用者の側)からのアクセス制限について学ぼう．一部の変数やルーチンへのアクセスしか必要無い場合には，``use`` 宣言の際に ``only`` を用いてそれ以外の名前を参照先からは無効にする(見えないようにする)ことが出来る．例えば :ref:`c9_refer_variables` の ``mod_variable`` から ``light_speed`` だけを用いたい場合には

::

      use mod_variable, only : light_speed

のように ``only :`` に続けて必要な変数名やルーチン名をカンマで区切ってリストすれば良い．また ``light_speed`` を別名で使いたい場合には

::

      use mod_variable, only : c => light_speed

のようにすることで，``light_speed`` の代わりに ``c`` という名前でアクセスすることが出来る．(ただしあくまで別名なので実態は``light_speed`` のままである．) これによって，例えばモジュール内部の変数と同じ名前の変数を参照先で使いたい場合に，名前の競合を避けることが出来る．

参照元からのアクセス制限
------------------------

参照先からのアクセス制限は言わば性善説の立場に立ったアクセス制限である [#]_．それに対して，性悪説の立場に立った，モジュールを提供する側からのアクセス制限も可能である．

モジュール内部で宣言された変数やルーチンには ``public`` や ``private`` などの属性を与えることが出来，この属性によってアクセス制限をすることが出来る．すなわち，``private`` 属性が指定された変数やルーチンはモジュール外からは直接見えず，内部からのみアクセスが可能になる．一方で，``public`` 属性が指定されたものは公開され，外部から自由にアクセスすることが出来る．Fortranのモジュールでは ``public`` がデフォルトである．

原則としてモジュールの内部でしか用いられないものは外部には公開しない方が良い．例えば以下のモジュールを考えよう．

::

    module mod_sample
      implicit none

      integer :: l, m, n

    end module mod_sample

いかにも他で使いそうな ``l``，``m``，``n`` という変数をモジュール内で宣言している．例えばメインプログラムからこのモジュールを利用する際に，他の用途に使おうと思ってこれらと同じ名前の変数を宣言するとコンパイルエラーとなってしまう．実はコンパイルエラーを出してくれればまだ良い方なのであって，メインプログラムで変数宣言を忘れた場合にはこれらの変数が普通に使えてしまう．モジュールの変数だと意識して使っていれば問題は無いのだが，そんなことはお構いなしに全く違う用途に使って値を書き換えてしまうと，モジュール内部でこれらの変数に依存しているようなコードは動作がおかしくなってしまうかもしれない．公開する必要が無いものは予め非公開にしておけば，このような不用意なバグの混入を未然に防ぐことが出来るのである．``public`` と ``private`` の指定方法はいくつかあって，個別に指定する場合は

::

      integer, private :: l, m, n

のように変数宣言時に属性を指定することが出来る．または

::

      integer :: l, m, n

      private :: l, m, n

のように別に指定することも可能である．なお，内部手続きの公開設定についても上の3行目のような形で手続名を並べれば良い．デフォルトで非公開としたい場合にはモジュール宣言の最初( ``implicit none`` の後)に ``private`` を指定しておけば，明示的に ``public`` 属性を付けない限りは非公開となる．実用的なプログラムではデフォルトを非公開の設定にし，必要な物だけに ``public`` 属性を指定することを強く推奨する．

以下は単位変換付きの物理定数モジュールの例である．デフォルトで ``private`` にすることでモジュール内部の変数には直接アクセス出来ないようし，その代わり必要な定数の値を返す関数を ``public`` にしてある．アクセスする手段(インターフェース)を敢えて限定することで，単位系のモード( ``unit``)に応じて物理定数の値が自動的に切り替わるようになっている [#]_．

::

    ! 物理定数モジュール
    module mod_const
      implicit none
      private ! デフォルトで非公開

      ! 単位選択フラグ: 1 => MKS, 2 => CGS
      integer, save :: unit = 1

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

.. _c9_structure:

構造型
======

    :doc:`サンプルコード参照 <chap09_sample5_f90>`

これまで扱ってきた ``integer`` や ``real`` のような組込み型だけで無く，新しいデータ型を自分で定義して用いることもできる．これを **構造型** と呼ぶ [#]_．構造型は組込み型やその配列はもちろん他の構造型を要素に持つことも出来る．

定義と使い方
------------

構造型は以下の様な形式で定義される．

::

      type :: name_of_type
        !型名 :: 要素名
        !の形で任意の変数を定義する
      end type name_of_type

組み込み型と同様に，定義した構造型の変数を以下のように宣言することによって使うことが出来る．

::

      type(name_of_type) :: name_of_variables

例えば以下の例では，倍精度実数型の ``x``，``y`` を要素に持つ新しい構造型 ``vector2`` を定義して用いている．

::

      ! 2次元のベクトル
      type :: vector2
        real(8) :: x, y
      end type vector2

      ! 構造型の変数を宣言
      type(vector2) :: a

      ! '%'を用いて各要素にアクセスが出来る
      a%x = 1.0_8
      a%y = 0.0_8

構造型の各要素にアクセスするには上の例のように"``%`` "を用いれば良い．構造型を用いると，常にセットで必要になるような複数のデータをまとめて保持することが出来るので，上手く利用すればプログラムが非常に見やすくなる．例えば非常に多くの引数を必要とするサブルーチンでも，構造型を利用してデータをまとめることで引数の数を減らして，スッキリとした形に書き換えることが出来るだろう [#]_．

ユーザー定義演算子
------------------

構造型の機能として特筆すべきは，構造型に対する演算子を自分で定義することが出来るという点である．これをユーザー定義演算子と呼ぶ．演算子の定義は以下のように総称名の場合とほぼ同様である．

::

      interface operator (.operator.)
         module procedure specific_procedure1, specific_procedure2
      end interface operator (.operator.)

演算子記号は ``+``，``-``，``*``，``/`` という組込み型に対して定義されている演算子か，または ``.operator.`` のように両側をピリオドで挟んだ名前のいずれかである．例として，ベクトル同士の和を各要素同士の和として ``+`` 演算子を定義しよう．以下の関数は2つのベクトルを引数に受け取り，要素同士の和を計算したものを結果として返す．

::

      ! + 演算子の中身
      function add2(a, b) result(ret)
        implicit none
        type(vector2), intent(in) :: a, b
        type(vector2) :: ret

        ret%x = a%x + b%x
        ret%y = a%y + b%y
      end function add2

これを ``interface`` を用いて

::

      interface operator (+)
         module procedure add2
      end interface operator (+)

のように宣言しておくことで ``type(vector2)`` の変数 ``a``，``b`` の和を ``a + b`` のように記述することが出来る．この ``+`` 演算子の計算の実態は上の ``add2`` という関数である．

また演算子についても総称名を用いることが出来る．すなわち ``add2`` は引数が2つとも ``type(vector2)`` であったが，例えばどちらか片方が実数型の場合の処理も定義して ``interface`` 宣言に加えておくことで，``+`` 演算子を総称名として用いることが出来る．これを演算子のオーバーロードと呼ぶ．

例えば，先ほどの ``add2`` に加えて ``add2_scalar1``，``add2_scalar2`` の2つの関数を ``interface`` に加えておく．

::

      interface operator (+)
         module procedure add2, add2_scalar1, add2_scalar2
      end interface operator (+)

ここで ``add2_scalar1``，``add2_scalar2`` はそれぞれ以下のように定義されたものとする．

::

      ! + 演算子の中身: vector2 + scalar
      function add2_scalar1(a, b) result(ret)
        implicit none
        type(vector2), intent(in) :: a
        real(8), intent(in) :: b
        type(vector2) :: ret

        ret%x = a%x + b
        ret%y = a%y + b
      end function add2_scalar1

      ! + 演算子の中身: scalar + vector2
      function add2_scalar2(a, b) result(ret)
        implicit none
        real(8), intent(in) :: a
        type(vector2), intent(in) :: b
        type(vector2) :: ret

        ret%x = a + b%x
        ret%y = a + b%y
      end function add2_scalar2

このようにしておけば，``vector2`` 型と倍精度実数型の ``+`` 演算が可能になる．この時，``a + 1.0_8`` のような演算では ``add2_scalar1`` が，``0.5_8 + a`` のような演算では ``add2_scalar2`` が自動的に呼び出されることになる．

ユーザー定義代入文
------------------

代入文( ``=``)に関しては，ユーザー定義演算子とは少し事情が異なるのでここで触れておく．まず代入文は，同じ構造型同士であればデフォルトで使用可能である(例えば ``type(vector2)`` 型の変数同士で ``a = b`` としても良い)．この場合は，構造型の各要素で単純に代入文が実行される．異なる型同士での代入には，ユーザー定義代入文の定義が必要である．(明示的に指定しない限り，コンパイラには何が正しい代入動作か判断出来ないため．)

ユーザー定義演算子と異なり，代入文の実態はサブルーチンを用いて定義する．

::

      ! = 中身
      subroutine assign2(a, b)
        implicit none
        type(vector2), intent(out) :: a ! intent(out) に注意
        real(8), intent(in)        :: b ! intent(in)  に注意

        ! どちらも同じ値
        a%x = b
        a%y = b
      end subroutine assign2

このサブルーチンを代入文として用いるには以下の様な ``interface`` 宣言を行う．

::

      interface assignment (=)
         module procedure assign2
      end interface assignment (=)

これによって ``a = 0.0_8`` のように，``=`` の右辺と左辺が異なる型の変数の場合であっても代入を行うことが出来るようになる．これにも総称名を用いてオーバーロードすることが可能である．

..
.. 課題
..

.. include:: kadai/chap09_kadai.rst

----

.. [#]

   実は総称名はモジュールに限らず，メインプログラムの内部手続きでも用いることが出来る．その場合あまりありがたみは感じないかもしれないが．

.. [#]

   モジュール利用者がモジュール内部の処理に悪影響を与えないように振る舞ってくれればこれでも良いのだが，過度の期待は禁物である．

.. [#]

   このように内部データを敢えて隠ぺいする(外から見えないようにする)ことをカプセル化(encapsulation)と呼ぶ. これは現代的なオブジェクト指向プログラミングの基本的な概念である．

.. [#]

   Fortran 2003以降では派生型と呼ばれるらしい．(オブジェクト指向プログラミングをサポートしたからであろう．)

.. [#]
   もっともこれは好みの問題であって，引数が山ほどあるサブルーチンの方が分かりやすいという人もいるかもしれない．
