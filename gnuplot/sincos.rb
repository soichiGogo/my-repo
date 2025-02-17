points = 100
step = Math::PI / points

File.open('sincos.dat', 'w'){|f|
  f.puts "# x sin(x) cos(x)"
  points.times{|i|
    x = i * step
    sin_val = Math.sin(x)
    cos_val = Math.cos(x)
    f.printf("%f %f %f\n", x, sin_val, cos_val)
  }
}

IO.popen("gnuplot -persist", "w"){|gp|
  gp.puts <<~GNUPLOT
    set terminal png
    set output 'sincos.png'

    set title "sincos"
    set xlabel "theta[rad]"
    set ylabel "Amplitude"

    set grid
    set xtics 0.314
    set ytics 0.2

    plot "sincos.dat" using 1:2 w lp linecolor rgb "red" title "sin","sincos.dat" using 1:3 w lp linecolor rgb "cyan" title "cos"
  GNUPLOT
}