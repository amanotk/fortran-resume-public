.. -*- coding: utf-8 -*-

.. highlight:: fortran
  :linenothreshold: 1

========
制御構造
========

ここではプログラムの動作を制御するための文法について学ぼう．と言っても覚えなければいけないことは ``if`` による条件分岐，``do`` による繰り返し，``select`` による条件分岐のみである．``goto`` という構文も存在するのだが，これはバグのもとになることから一般的には使わないほうが良いとされており，従ってここでも敢えて扱わない．

    サンプルプログラム

    - :doc:`sample1.f90 <chap04_sample1_f90>` : 条件分岐(if)
    - :doc:`sample2.f90 <chap04_sample2_f90>` : 反復処理(doループ1)
    - :doc:`sample3.f90 <chap04_sample3_f90>` : 反復処理(doループ2)
    - :doc:`sample4.f90 <chap04_sample4_f90>` : 反復処理(doループ3)
    - :doc:`sample5.f90 <chap04_sample5_f90>` : 条件分岐(select)

.. contents:: この章の内容
    :depth: 2

条件分岐(if)
============

``if`` による条件分岐は例えばユーザーの入力によって動作を変更する場合などに用いる．典型的な使い方は以下のようなものである．（これは閏年の判定例である．）

.. literalinclude:: sample/chap04/sample1.f90
  :language: fortran
  :lines: 4-19
  :lineno-match:
  :caption: :doc:`sample1.f90 <chap04_sample1_f90>` 抜粋

このように ``if`` に続く ``()`` の中に条件式(conditional)を記述し，その条件が真( ``.true.``)の時には ``then`` に続く処理が実行され，偽( ``.false.``)の時には ``else if`` または ``else`` で更に条件判定をすることになる．また

::

  if( conditional ) then
    ! 処理
  end if

や

::

  if( conditional ) then
    ! 処理1
  else
    ! 処理2
  end if

のように書くことも出来る．構文自体はそれほど難しくないので，ここで注意すべきは条件判定の部分だけであろう．以下の表に条件式に用いられることの多い演算子をまとめてある．なおFortran 77では ``>`` のような演算子(関係演算子と呼ばれる)は正式にはサポートされていなかった．このため古いコードには ``.gt.`` のような演算子を見かけることもあるかも知れないが，自分で新しくプログラムを作成する際にはこのような古い形式は使うべきではない．新しい形式は ``/=`` 以外のものについてはC言語を始めとする他の多くの言語と同じなのでこちらを用いることを強く推奨する．ちなみにC言語などでは ``/=`` ではなく ``!=`` が用いられる．

特に実数の値が等しいかどうかを判定する際には注意が必要である．すなわち，実数に対しては ``==`` を使うことは出来ない．なぜなら2つの実数がほぼ等しいように見えても ``==`` による判定では全てのビットが厳密に等しくなければ真とは判定されないからである．従って，代わりに例えば差の絶対値 ``abs(A-B)`` が十分小さいかどうかで判定しなくてはならない [#]_．

.. tabularcolumns:: |p{0.3 \textwidth}|p{0.3 \textwidth}|p{0.3 \textwidth}|
.. list-table:: 条件演算子
    :width: 80%
    :widths: 30, 30, 30
    :header-rows: 1

    * - 演算子
      - Fortran 77形式
      - 意味

    * - ``A >  B``
      - ``A .gt. B``
      - ``A`` の方が ``B`` よりも大きければ真

    * - ``A >= B``
      - ``A .ge. B``
      - ``A`` が ``B`` 以上であれば真

    * - ``A <  B``
      - ``A .lt. B``
      - ``A`` の方が ``B`` よりも小さければ真

    * - ``A <= B``
      - ``A .le. B``
      - ``A`` が ``B`` 以下であれば真

    * - ``A == B``
      - ``A .eq. B``
      - ``A`` と ``B`` が厳密に等しければ真

    * - ``A /= B``
      - ``A .ne. B``
      - ``A`` と ``B`` が等しくなければ真


また条件判定が複雑な時には以下の論理演算子を用いることになるだろう．

.. tabularcolumns:: |p{0.3 \textwidth}|p{0.3 \textwidth}|p{0.3 \textwidth}|
.. list-table:: 論理演算子
    :width: 80%
    :widths: 30, 30, 30
    :header-rows: 1

    * - 演算子
      - 意味
      - 使い方

    * - ``.and.``
      - 論理積
      - ``(条件式1) .and. (条件式2)``

    * - ``.or.``
      - 論理和
      - ``(条件式1) .or.  (条件式2)``

    * - ``.not.``
      - 否定
      - ``.not. (条件式)``

    * - ``.eqv.``
      - 論理等価
      - ``(条件式1) .eqv. (条件式2)``

    * - ``.neqv.``
      - 論理非等価
      - ``(条件式1) .neqv. (条件式2)``

使い方は例えば

::

  integer :: n

  if ( 2 < n .and. n < 5 ) then
    write(*,*) 'n is larger than 2 and smaller than 5'
  end if

と言った具合である．``2 < n < 5`` のような数学的な書き方はできないので注意が必要である．

さらに複雑な条件分岐の場合には以下のように ``if`` 文を入れ子で使うことも出来る．

::

  if ( conditional 1 ) then
    if ( conditional 2 ) then
      ! 処理1
    else
      ! 処理2
    end if
  end if

ただし何重にも深く入れ子になった ``if`` 文の実行効率はあまり良くないので出来るかぎり浅い条件分岐に留めておいた方が良い．

以下は :doc:`sample1.f90 <chap04_sample1_f90>` の11-19行目の閏年の判定と全く同じことを入れ子にした ``if`` で実装した例である．

.. literalinclude:: sample/chap04/sample1.f90
  :language: fortran
  :lines: 21-34
  :lineno-match:
  :caption: :doc:`sample1.f90 <chap04_sample1_f90>` 抜粋



反復処理(do)
============

.. _c4_do:

決まった回数の繰り返し(do)
--------------------------

決まった繰り返しの処理をするために用いるのが ``do`` (従ってこの反復処理は ``do`` ループと呼ばれる)である．これも使い方は至ってシンプルである．

.. literalinclude:: sample/chap04/sample2.f90
  :language: fortran
  :lines: 10-15
  :lineno-match:
  :caption: :doc:`sample2.f90 <chap04_sample2_f90>` 抜粋

は1から10までの和を順次求めながら結果を出力している．より一般には

::

  do i = lower, upper, stride
    ! 繰り返し処理
  end do

のような形で書くことになる．上の例では整数型変数 ``i`` は ``do`` 変数と呼ばれ，``do`` ループの中で ``i`` の値が ``lower`` から ``upper`` まで ``stride`` ずつ変化する．``stride`` は省略することも可能であり，その場合は ``1`` と解釈される．また ``stride`` は負の値であっても良い(当然この時は ``lower > upper`` でなければループ内の処理は実行されない)．通常 ``do`` 変数は整数型でなければならないが，実数型などでもコンパイル出来てしまう環境もあり，そのような場合は思わぬバグの原因となってしまう．間違いを未然に防ぐためにも ``do`` 変数には整数型を用いること．

例えば次は先ほどの例の和を求める処理を1つおきに実行する．

.. literalinclude:: sample/chap04/sample2.f90
  :language: fortran
  :lines: 18-23
  :lineno-match:
  :caption: :doc:`sample2.f90 <chap04_sample2_f90>` 抜粋


また ``if`` 文の場合と同様に ``do`` ループに関しても以下のように入れ子(多重ループ)にすることが出来る．以下は2重ループの例である．

.. literalinclude:: sample/chap04/sample2.f90
  :language: fortran
  :lines: 34-39
  :lineno-match:
  :caption: :doc:`sample2.f90 <chap04_sample2_f90>` 抜粋

この部分の実行結果は以下のようになる．

.. code-block:: bash

  --- Do loop #4 ---
   (           1 ,           1 ) =>            1
   (           1 ,           2 ) =>            2
   (           1 ,           3 ) =>            3
   (           2 ,           1 ) =>            4
   (           2 ,           2 ) =>            5
   (           2 ,           3 ) =>            6
   (           3 ,           1 ) =>            7
   (           3 ,           2 ) =>            8
   (           3 ,           3 ) =>            9



条件を指定した繰り返し(do while)
--------------------------------

繰り返しの処理には基本的に先ほどの ``do`` ループを用いれば良いのだが，これを少し違った形式で行う ``do while`` なる構文も用意されている．これは

::

  do while( conditional )
    ! 繰り返し処理
  end do

のような形で用い，``()`` 内の条件式が真( ``.true.``)の間は繰り返し処理が行われる．例えば

::

  integer :: i
  real(8) :: sum

  i = 1
  sum = 0
  do while(i <= 10)
     sum = sum + i
     i = i + 1
     write(*,*) i, sum
  end do

は先ほどの例 :doc:`sample2.f90 <chap04_sample3_f90>` の最初の ``do`` ループと同じ処理を実行する．この場合はあえて ``do while`` を用いる意味はあまり感じられないが，繰り返し回数が予め分からない処理ではこのような形式を用いるとスマートに書ける場面にもしばしば遭遇する．例えば反復計算によって実数型の値の収束判定をする場合などは

::

      real(8) :: x

      do while(abs(x) > 1.0e-8_8)
        ! 繰り返し処理
      end do

などのように非常にスッキリと記述できる．この例では ``abs(x)`` の値が :math:`10^{-8}` 以下になるまで反復を続ける．例えば，以下は逐次計算によって平方根を求める計算である．

.. literalinclude:: sample/chap04/sample3.f90
  :language: fortran
  :lines: 20-26
  :lineno-match:
  :caption: :doc:`sample3.f90 <chap04_sample3_f90>` 抜粋


複雑な処理(exitとcycle)
-----------------------

単純な繰り返しだけでなく，より柔軟な制御を行うには ``exit`` や ``cycle`` を用いる．``exit`` では ``do`` ループの中から途中で抜けることが出来，``cycle`` ではループ内のそれ以降の処理を行わずにループ先頭に戻ることがで出来る．これらを用いると意図的に作った無限ループから条件を満たした時だけ抜け出すようなプログラムも簡単に作ることができる．例えば以下の例を見てみよう．

.. literalinclude:: sample/chap04/sample4.f90
  :language: fortran
  :lines: 9-28
  :lineno-match:
  :caption: :doc:`sample4.f90 <chap04_sample4_f90>` 抜粋

この例では標準入力からの10より小さい正の整数を受け取り，受け取った数の和を求める．ただし0以下の値を受け取った場合は処理を終了する．また，10以上の値受け取った場合はエラーを表示し，和はとらずに無視する．実行結果は例えば以下のようになる．

.. code-block:: bash

  $ ./a.out
   Input a positive integer (less than 10):
  5                                            # キーボード入力
   current count =            5
  
   Input a positive integer (less than 10):
  4                                            # キーボード入力
   current count =            9
  
   Input a positive integer (less than 10):
  10                                            # キーボード入力
   error : input >= 10
  
   Input a positive integer (less than 10):
  0                                            # キーボード入力
   error : input <= 0
   last count =            9


なお，同じ動作を実現する方法は1つとは限らない．例えば ``while`` の条件判定を ``increment <= 0`` と変更すれば，この条件に対応する ``if`` は必要がなくなる．複数の方法がある場合にはより分かりやすい方(すなわち間違いが発生しにくい方)を採用すれば良い．ちなみに無限ループを作るには ``while (.true.)`` は必ずしも必要では無く，

::

      do
        ! exitで抜けないかぎりここの処理が無限に繰り返される
      end do

のように書くことも可能である．


条件分岐(select)
================

``select`` 構文を用いても条件分岐を行うことも出来る．基本的には ``if`` を用いれば同じことは実現出来るのだが，場合によっては ``select`` を用いた方がよりスッキリとした形で書ける事があるので知っておいて損はない．典型的には整数や文字列の値で場合分けを制御する際に用いる(実数型には用いることは出来ない)．

一番基本的な使い方は以下のようなものである．

.. literalinclude:: sample/chap04/sample5.f90
  :language: fortran
  :lines: 7-23
  :lineno-match:
  :caption: :doc:`sample5.f90 <chap04_sample5_f90>` 抜粋

``case`` で入力された整数の値に応じて処理を切り替えている．また，どの ``case`` の条件にも当てはまらない場合の処理は ``case deafault`` によって行えば良い．

この例を見ただけでは ``if-elif-else`` を使うのとほとんど変わらないように感じられるので，もう少し ``select`` の利点が生かされた例として以下を見てみよう．ここでは入力された整数 ``score`` (テストの点だと思おう)の値によって場合分けをしている．

.. literalinclude:: sample/chap04/sample5.f90
  :language: fortran
  :lines: 26-44
  :lineno-match:
  :caption: :doc:`sample5.f90 <chap04_sample5_f90>` 抜粋

この例のように ``case`` では単一の値だけでなく値の範囲を指定することができる．範囲の指定は ``case(下限:上限)`` のような形ですれば良い．

さらに

.. literalinclude:: sample/chap04/sample5.f90
  :language: fortran
  :lines: 47-62
  :lineno-match:
  :caption: :doc:`sample5.f90 <chap04_sample5_f90>` 抜粋

は文字列の値によって分岐する例である．このように1つの ``case`` で複数の値をカンマで区切って指定することも出来る．

..
.. 課題
..

.. include:: kadai/chap04_kadai.rst

----

.. [#]

   ``abs(x)`` は ``x`` の絶対値を返す組込み関数である．
