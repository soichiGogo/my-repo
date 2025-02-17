File.open("protdata_4_1.txt", "w"){|f|
    21.times{|i|
        f.printf("%f %d\n", i / 20.0, 180 * i / 20)
    }
}

IO.popen("gnuplot", "w"){|gp|
    gp.puts <<~GNUPLOT
        set terminal png
        set output 'servomotor_4_1.png'
        set xlabel 'Time'
        set ylabel 'Angle (°)'
        set xrange [0:1]
        set yrange [0:180]
        set xtics 0.1
        set title 'Servo Motor Angle'
        plot 'protdata_4_1.txt' with lines title 'graph'
    GNUPLOT
}
