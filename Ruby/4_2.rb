open("protdata_4_2.txt", "w"){|f|
    21.times{|i|
        rad = i / 20.0 * Math::PI
        f.printf("%f %f %f\n", i / 20.0, 90 * (1-Math.cos(rad)), 180 * (1/(1+Math.exp(10.0 - i))))
    }
}

open("command_4_2.txt", "w"){|f|
    f.puts "set terminal png"
    f.puts "set output 'servomotor_4_2.png'"
    f.puts "set xlabel 'Time'"
    f.puts "set ylabel 'Angle (°)'"
    f.puts "set xrange [0:1]"
    f.puts "set yrange [0:180]"
    f.puts "set xtics 0.1"
    f.puts "set title 'Servo Motor Angle'"
    f.puts "set style line 1 pointtype 7 pointsize 2"
    f.puts "set style line 2 pointtype 5 pointsize 2"
    f.puts "plot 'protdata_4_2.txt' using 1:2 with lp ls 1 title 'cos', 'protdata_4_2.txt' using 1:3 with lp ls 2 title 'sigmoid'"
}

`gnuplot command_4_2.txt`