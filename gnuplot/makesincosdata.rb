# データポイントの数
points = 100
# 0から2πまでの範囲でデータを生成
step = Math::PI / points

# ファイルに書き込み
File.open('sincos.dat', 'w'){|f|
  f.puts "# x sin(x) cos(x)"
  points.times{|i|
    x = i * step
    sin_val = Math.sin(x)
    cos_val = Math.cos(x)
    f.printf("%f %f %f\n", x, sin_val, cos_val)
  }
}

# plot "sincos.dat" using 1:2 w lp title "sin","sincos.dat" using 1:3 w lp title "cos"

#赤とシアンにする
# linecolor rgb "red"("#FF0000",rgb(255,0,0))
# linecolor rgb "cyan"("#00FFFF",rgb(0,255,255))をplotコマンドに追加
#plot "sincos.dat" using 1:2 w lp linecolor rgb "red" title "sin","sincos.dat" using 1:3 w lp linecolor rgb "cyan" title "cos"

#タイトルに「sine and cosine」,x軸ラベルに「theta[rad]」,y軸ラベルに「Amplitude」を追加
#set title "sine and cosine"
#set xlabel "theta[rad]"
#set ylabel "Amplitude"
#plot "sincos.dat" using 1:2 w lp linecolor rgb "red" title "sin","sincos.dat" using 1:3 w lp linecolor rgb "cyan" title "cos"

#グリッドあり、x軸の刻みを0.314、y軸の刻みを0.2にする
#set grid
#set xtics 0.314
#set ytics 0.2
#plot "sincos.dat" using 1:2 w lp linecolor rgb "red" title "sin","sincos.dat" using 1:3 w lp linecolor rgb "cyan" title "cos"





