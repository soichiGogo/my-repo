points = 100
step = Math::PI / points
open('sincos.dat', 'w'){|f|
  f.puts "# x sin(x) cos(x)"
  points.times{|i|
    x = i * step
    sin_val = Math.sin(x)
    cos_val = Math.cos(x)
    f.printf("%f %f %f\n", x, sin_val, cos_val)
  }
}

open("command_sincos.txt", "w"){|f|
  f.puts "set terminal png"
  f.puts "set output 'sincos.png'"
  f.puts "set title 'sincos'"
  f.puts "set xlabel 'theta[rad]'"
  f.puts "set ylabel 'Amplitude'"
  f.puts "set grid"
  f.puts "set xtics 0.314"
  f.puts "set ytics 0.2"
  f.puts "plot 'sincos.dat' using 1:2 w lp linecolor rgb 'red' title 'sin','sincos.dat' using 1:3 w lp linecolor rgb 'cyan' title 'cos'"
}

`gnuplot command_sincos.txt`
