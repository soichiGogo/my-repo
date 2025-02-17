File.open("protdata_4_2.txt", "w"){|f|
    21.times{|i|
        rad = i / 20.0 * Math::PI
        f.printf("%f %f %f\n", i / 20.0, 90 * (1-Math.cos(rad)), 180 * (1/(1+Math.exp(10.0 - i))))
    }
}

IO.popen("gnuplot", "w"){|gp|
    gp.puts <<~GNUPLOT
        set terminal png
        set output 'servomotor_4_2.png'
        set xlabel 'Time'
        set ylabel 'Angle (°)'
        set xrange [0:1]
        set yrange [0:180]
        set xtics 0.1
        set title 'Servo Motor Angle'
        plot 'protdata_4_2.txt' using 1:2 with lp title 'cos', 'protdata_4_2.txt' using 1:3 with lp title 'sigmoid'
    GNUPLOT
}
