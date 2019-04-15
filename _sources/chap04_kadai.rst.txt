.. -*- coding: utf-8 -*-

第4章 演習課題
==============

課題1
-----

サンプルプログラムをコンパイル・実行して動作を確認せよ．さらに，適宜修正してその実行結果を確認せよ．


課題2
-----

標準入力から2つの整数( :math:`n, m` とする)を読み込み，その大小を比較するプログラムを作成せよ．例えば :math:`n = 1, m = 2` なら以下のように ``1 is smaller than 2`` と表示する．

.. code-block:: bash

    $./a.out
     Input two integers:
    1    # キーボード入力
    2    # キーボード入力
               1  is smaller than            2



同様に :math:`n = 2, m = 1` なら ``2 is larger than 1``, :math:`n = m = 1` なら ``1 is equal to 1`` などと表示するものとする．


課題3
-----

:math:`0^\circ` から :math:`180^\circ` まで :math:`10^\circ` 刻みの :math:`\theta` および， :math:`\sin \theta`, :math:`\cos \theta` を標準出力に表示するプログラムを作成せよ(以下のように各 :math:`\theta` の値ごとに改行せよ)．またこの結果をリダイレクトを用いてファイルとして記録し，gnuplotを用いてこのファイルのデータとgnuplotに組み込みの三角関数を共に図示せよ．なお三角関数の引数はラジアン単位であることに注意せよ．プログラムの出力結果は以下のようなものとなる．

.. code-block:: bash

     $ ./a.out
       0.0000000000000000        0.0000000000000000        1.0000000000000000
       10.000000000000000        ...                       ...
       20.000000000000000        ...                       ...
       ...                       ...                       ...
       180.00000000000000        ...                       ...

なおリダイレクトでデータファイルを作成するには

.. code-block:: bash

     $ ./a.out > data.dat

とすれば良い．gnuplotでは

.. code-block:: bash

     > plot   'data.dat' using 1:2 w lp, sin(x/180*pi)
     > replot 'data.dat' using 1:3 w lp, cos(x/180*pi)

などとすれば結果を確認出来る．(忘れている人は復習せよ!)


課題4
-----

標準入力から与えられた2つの整数\ :math:`m, n \ge 1` の最大公約数を表示するプログラムを作成せよ．最大公約数を求めるには以下のアルゴリズム(ユークリッドの互除法)を用いるとよい．

    #. :math:`m` を :math:`n` で割った余り :math:`r` を求める．
    #. もし :math:`r = 0` ならば :math:`n` が最大公約数である．
    #. もし :math:`r \neq 0` ならば， :math:`m` に :math:`n` を， :math:`n` に :math:`r` を代入して[1]に戻る(繰り返す)．

なお，組み込み関数 ``mod`` を用いて

.. code-block:: fortran

    r = mod(m, n)

とすれば ``m`` を ``n`` で割った余りを ``r`` に代入することが出来る．


課題5
-----

以下の級数計算により自然対数の底 :math:`e` の近似値を求めるプログラムを作成せよ．

.. math::


    e \simeq \sum_{n=0}^{N} \frac{1}{n !}. \quad (0! = 1に注意せよ)

ただし以下の条件を満たすこと．

    -  級数の項数 :math:`N` および許容誤差 :math:`\epsilon` を標準入力から読み込む．
    -  :math:`N > 1` でない場合および :math:`0 < \epsilon < 1` でない場合にはエラーメッセージを表示して終了する．
    -  誤差が :math:`\epsilon` 以下になった時点か， :math:`n = N` まで計算した時点で級数計算を打ち切る．
    -  最後に収束したかどうか，最終的な項数 :math:`N` ，真値，近似値，相対誤差を表示して終了する．

出力のイメージとしては例えば以下のようなものである．

.. code-block:: bash

    $ ./a.out
    10          # キーボード入力
    1.0e-8      # キーボード入力
     Did not converge !
     N                  :           10
     Exact value        :    2.7182818284590451
     Approximated value :    2.7182818011463845
     Error              :   1.00477663102110533E-008


課題6
-----

標準入力から文字列(英単語)を読み込み，それが ``food``, ``animal``, ``vehicle``, ``others`` (それ以外)のいずれかを判定し，表示するプログラムを作成せよ．ただし ``exit`` が入力されるまでプログラムは終了せず何度でも入力を受け付けるものとする．なお以下の英単語リスト以外のものは ``others`` と判断してよい:
``apple``, ``orange``, ``banana``, ``dog``, ``cat``, ``lion``, ``car``,
``airplane``, ``motorcycle`` ．

実行結果は例えば以下のような出力になるだろう．

.. code-block:: bash

    $ ./a.out
    apple    # キーボード入力
     food
    cat      # キーボード入力
     animal
    car      # キーボード入力
     vehicle
    dog      # キーボード入力
     animal
    airplane # キーボード入力
     vehicle
    bike     # キーボード入力
     others
    exit     # キーボード入力
     Now exit program...


課題7 :sup:`†`
---------------

以下の漸化式

.. math::

   p_{n+1} = p_n + \alpha p_n (1 - p_n)

で定義される数列 :math:`p_n (n=0, 1, \ldots)` を考える．初期値 :math:`p_0 = 0.9` から数列を生成し，そのうち :math:`n=100, \ldots, 200` までを :math:`\alpha` の関数として :math:`1 < \alpha < 3` の範囲でプロットせよ． :math:`\alpha` を :math:`10^{-3}` 刻みで変えながらプロットすると結果は以下のようになるだろう．

.. figure:: figure/logistic.png
    :align: center
    :width: 480px

    ロジスティック写像

このような写像はロジスティック写像と呼ばれ，非常に単純な式ながら一定の条件を満たすときにはカオスを生み出すことが知られている．
