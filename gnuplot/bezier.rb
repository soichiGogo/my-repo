p0 = [0, 0]    # 開始点
p1 = [1, 2]    # 制御点1
p2 = [2, -1]   # 制御点2
p3 = [4, 2]    # 終了点
p4 = [5, 0]    # 制御点3

def bezier_point_2(t, p0, p1, p2, p3)
  x = (1-t)**3 * p0[0] + 3*(1-t)**2 * t * p1[0] + 3*(1-t) * t**2 * p2[0] + t**3 * p3[0]
  y = (1-t)**3 * p0[1] + 3*(1-t)**2 * t * p1[1] + 3*(1-t) * t**2 * p2[1] + t**3 * p3[1]
  [x, y]
end

def bezier_point_3(t, p0, p1, p2, p3, p4)
  x = (1-t)**4 * p0[0] + 4*(1-t)**3 * t * p1[0] + 6*(1-t)**2 * t**2 * p2[0] + 4*(1-t) * t**3 * p3[0] + t**4 * p4[0]
  y = (1-t)**4 * p0[1] + 4*(1-t)**3 * t * p1[1] + 6*(1-t)**2 * t**2 * p2[1] + 4*(1-t) * t**3 * p3[1] + t**4 * p4[1]
  [x, y]
end

File.open('bezier.dat', 'w'){|f|
  100.times{|i|
    t = i / 100.0
    point = bezier_point_3(t, p0, p1, p2, p4, p3)
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
if p1[0] < x_range[0]
  x_range[0] = p1[0]
end
if p1[0] > x_range[1]
  x_range[1] = p1[0]
end
if p2[0] < x_range[0]
  x_range[0] = p2[0]
end
if p2[0] > x_range[1]
  x_range[1] = p2[0]
end
if p4[0] < x_range[0]
  x_range[0] = p4[0]
end
if p4[0] > x_range[1]
  x_range[1] = p4[0]
end
if p1[1] < y_range[0]
  y_range[0] = p1[1]
end
if p1[1] > y_range[1]
  y_range[1] = p1[1]
end 
if p2[1] < y_range[0]
  y_range[0] = p2[1]
end
if p2[1] > y_range[1]
  y_range[1] = p2[1]
end
if p4[1] < y_range[0]
  y_range[0] = p4[1]
end
if p4[1] > y_range[1]
  y_range[1] = p4[1]
end

x_range[0] -= 1
x_range[1] += 1
y_range[0] -= 1
y_range[1] += 1



IO.popen("gnuplot", "w"){|gp|
  gp.puts <<~GNUPLOT
    set terminal png
    set output 'bezier.png'
    set title "BezierCurve"
    set xlabel "x"
    set ylabel "y"
    set xrange [#{x_range[0]}:#{x_range[1]}]
    set yrange [#{y_range[0]}:#{y_range[1]}]
    plot "bezier.dat" index 0 with lines title "BezierCurve", "bezier.dat" index 1 with points title "ControlPoints"
  GNUPLOT
}

