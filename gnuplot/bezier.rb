def kaijou(n)
  result = 1
  n.times{|i|
    result *= (n-i)
  }
  result
end

def make_bezier_point(t, points)
  x = 0
  y = 0
  points.each_with_index{ |p, i|
    x += kaijou(points.size - 1)/kaijou(i)/kaijou(points.size - 1 - i) * (1-t)**(points.size - 1 - i) * t**i * p[0]
    y += kaijou(points.size - 1)/kaijou(i)/kaijou(points.size - 1 - i) * (1-t)**(points.size - 1 - i) * t**i * p[1]
  }
  [x, y]
end

p0 = [0, 0]    # 開始点
p1 = [1, 2]    # 制御点1
p2 = [3, 6]   # 制御点2
p3 = [4, 8]    # 制御点3
p4 = [5, 0]    # 終了点

open('bezier.dat', 'w'){|f|
  100.times{|i|
    t = i / 100.0
    point = make_bezier_point(t, [p0, p1, p2, p3, p4])
    f.printf("%f %f\n", point[0], point[1])
  }

  f.printf("\n\n")
  f.printf("%f %f\n", p0[0], p0[1])
  f.printf("%f %f\n", p1[0], p1[1])
  f.printf("%f %f\n", p2[0], p2[1])
  f.printf("%f %f\n", p3[0], p3[1])
  f.printf("%f %f\n", p4[0], p4[1])
}

x_range = [p0[0], p3[0]]
y_range = [p0[1], p3[1]]
points = [p0, p1, p2, p3, p4]
points.each{ |p|
  if p[0] < x_range[0]
    x_range[0] = p[0]
  end
  if p[0] > x_range[1]
    x_range[1] = p[0]
  end
  if p[1] < y_range[0]
    y_range[0] = p[1]
  end
  if p[1] > y_range[1]
    y_range[1] = p[1]
  end
}

x_range[0] -= 1
x_range[1] += 1
y_range[0] -= 1
y_range[1] += 1

open("command_bezier.txt", "w"){|f|
  f.puts "set terminal png"
  f.puts "set output 'bezier.png'"
  f.puts "set title 'BezierCurve'"
  f.puts "set xlabel 'x'"
  f.puts "set ylabel 'y'"
  f.puts "set xrange [#{x_range[0]}:#{x_range[1]}]"
  f.puts "set yrange [#{y_range[0]}:#{y_range[1]}]"
  f.puts "set grid"
  f.puts "set style line 1 lt 1 lw 2"
  f.puts "set style line 2 lt 2 lw 2"
  f.puts "plot 'bezier.dat' index 0 ls 1 with lines title 'BezierCurve', 'bezier.dat' index 1 ls 2 with points title 'ControlPoints'"
}

`gnuplot command_bezier.txt`