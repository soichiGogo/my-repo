# 3点のデータを定義
points = [
    [0, 2],    # [x1, y1]
    [1, 3],    # [x2, y2]
    [2, 6]     # [x3, y3]
]
  
# 連立方程式を解く
# y = ax² + bx + c の形で
# 行列式を使って解く
def solve_quadratic_fit(points)
  x1, y1 = points[0]
  x2, y2 = points[1]
  x3, y3 = points[2]
  
  # 行列の要素を計算
  a11 = x1**2; a12 = x1; a13 = 1
  a21 = x2**2; a22 = x2; a23 = 1
  a31 = x3**2; a32 = x3; a33 = 1
  
  # 行列式
  det = a11*(a22*a33 - a23*a32) - a12*(a21*a33 - a23*a31) + a13*(a21*a32 - a22*a31)
  
  # クラメルの公式で解く
  # y1 a12 a13    a11 y1 a13    a11 a12 y1
  # y2 a22 a23    a21 y2 a23    a21 a22 y2
  # y3 a32 a33    a31 y3 a33    a31 a32 y3
  a = (y1*(a22*a33 - a23*a32) - a12*(y2*a33 - a23*y3) + a13*(y2*a32 - a22*y3)) / det
  b = (a11*(y2*a33 - a23*y3) - y1*(a21*a33 - a23*a31) + a13*(a21*y3 - y2*a31)) / det
  c = (a11*(a22*y3 - y2*a32) - a12*(a21*y3 - y2*a31) + y1*(a21*a32 - a22*a31)) / det
  
  [a, b, c]
end

a, b, c = solve_quadratic_fit(points)

File.open('fitting.dat', 'w') do |f|
  f.puts "# x y"
  # 元の点を保存
  points.each do |x, y|
    f.puts "#{x} #{y}"
  end
  f.puts "\n\n" # データセットの区切り
  
  # フィッティング曲線の点を保存
  for i in -50..60
    x = i * 0.1
    y = a * x**2 + b * x + c
    f.puts "#{x} #{y}"
  end
end

#plot "fitting.dat" index 0 with points pt 7 title "元データ","fitting.dat" index 1 with lines title "フィッティング曲線"
