points = [
    [0, 2],
    [1, 3],
    [2, 6]
]

plot_x_range = [points[0][0], points[2][0]]
plot_y_range = [points[0][1], points[2][1]]

points.each{|x, y|
  if x < plot_x_range[0]
    plot_x_range[0] = x
  end
  if x > plot_x_range[1]
    plot_x_range[1] = x
  end
  if y < plot_y_range[0]
    plot_y_range[0] = y
  end
  if y > plot_y_range[1]
    plot_y_range[1] = y
  end
}

plot_x_range[0] -= 3
plot_x_range[1] += 3
plot_y_range[0] -= 3
plot_y_range[1] += 3
  
def solve_fit_equation(points)
  x1, y1 = points[0]
  x2, y2 = points[1]
  x3, y3 = points[2]
  
  a11 = x1**2; a12 = x1; a13 = 1
  a21 = x2**2; a22 = x2; a23 = 1
  a31 = x3**2; a32 = x3; a33 = 1

  det = a11*(a22*a33 - a23*a32) - a12*(a21*a33 - a23*a31) + a13*(a21*a32 - a22*a31)
  
  # クラメルの公式
  # y1 a12 a13    a11 y1 a13    a11 a12 y1
  # y2 a22 a23    a21 y2 a23    a21 a22 y2
  # y3 a32 a33    a31 y3 a33    a31 a32 y3
  a = (y1*(a22*a33 - a23*a32) - a12*(y2*a33 - a23*y3) + a13*(y2*a32 - a22*y3)) / det
  b = (a11*(y2*a33 - a23*y3) - y1*(a21*a33 - a23*a31) + a13*(a21*y3 - y2*a31)) / det
  c = (a11*(a22*y3 - y2*a32) - a12*(a21*y3 - y2*a31) + y1*(a21*a32 - a22*a31)) / det
  
  [a, b, c]
end

a, b, c = solve_fit_equation(points)

open('fitting.dat', 'w'){|f|
  f.puts "# x y"

  points.each{|x, y|
    f.puts "#{x} #{y}"
  }
  f.puts "\n\n"
  
  plot_x_range[0].step(plot_x_range[1], 0.1){|i|
    x = i
    y = a * x**2 + b * x + c
    f.puts "#{x} #{y}"
  }
}

x_range = [points[0][0], points[2][0]]
y_range = [points[0][1], points[2][1]]

points.each{|x, y|
  if x < x_range[0]
    x_range[0] = x
  end
  if x > x_range[1]
    x_range[1] = x
  end
  if y < y_range[0]
    y_range[0] = y
  end
  if y > y_range[1]
    y_range[1] = y
  end
}

x_range[0] -= 3
x_range[1] += 3
y_range[0] -= 3
y_range[1] += 3

open("command_fitting.txt", "w"){|f|
  f.puts "set terminal png"
  f.puts "set output 'fitting.png'"
  f.puts "set title 'FittingCurve'"
  f.puts "set xlabel 'x'"
  f.puts "set ylabel 'y'"
  f.puts "set xrange [#{x_range[0]}:#{x_range[1]}]"
  f.puts "set yrange [#{y_range[0]}:#{y_range[1]}]"
  f.puts "set grid"
  f.puts "set style line 1 lt 1 lw 4"
  f.puts "set style line 2 lt 2 lw 2"
  f.puts "plot 'fitting.dat' index 0 ls 1 with points title 'OriginalData','fitting.dat' index 1 ls 2 with lines title 'FittingCurve'"
}

`gnuplot command_fitting.txt`