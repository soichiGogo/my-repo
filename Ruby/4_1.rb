open("protdata_4_1.txt", "w"){|f|
    21.times{|i|
        f.printf("%f %d\n", i / 20.0, 180 * i / 20)
    }
}

open("command_4_1.txt", "w"){|f|
    f.puts "set terminal png"
    f.puts "set output 'servomotor_4_1.png'"
    f.puts "set xlabel 'Time'"
    f.puts "set ylabel 'Angle (°)'"
    f.puts "set xrange [0:1]"
    f.puts "set yrange [0:180]"
    f.puts "set xtics 0.1"
    f.puts "set title 'Servo Motor Angle'"
    f.puts "set grid"
    f.puts "set style line 1 pointtype 4 pointsize 2"
    f.puts "plot 'protdata_4_1.txt' with lp ls 1 title 'graph'"
}

`gnuplot command_4_1.txt`