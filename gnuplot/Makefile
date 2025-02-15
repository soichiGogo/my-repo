.PHONY: data plot clean

# データ生成: makesincosdata.rbを実行してsincos.datを作成
data:
	 ruby makesincosdata.rb

# プロット: データ生成後にgnuplotコマンドでグラフを表示
plot: data
	 gnuplot -e "set title 'sine and cosine'; \
	             set xlabel 'theta[rad]'; \
	             set ylabel 'Amplitude'; \
	             set grid; \
	             set xtics 0.314; \
	             set ytics 0.2; \
	             plot 'sincos.dat' using 1:2 with lines linecolor rgb 'red' title 'sin', \
	                  'sincos.dat' using 1:3 with lines linecolor rgb 'cyan' title 'cos'; \
	             pause -1"

# クリーンアップ: 作成したファイルの削除
clean:
	 rm -f sincos.dat 