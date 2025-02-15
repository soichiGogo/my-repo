# ベジエ曲線の制御点（x, y座標）
p0 = [0, 0]    # 開始点
p1 = [1, 3]    # 制御点1
p2 = [2, -1]   # 制御点2
p3 = [4, 2]    # 終了点
p4 = [5, 0]    # 制御点3

# ベジエ曲線の計算関数
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

# データファイルの生成
File.open('bezier.dat', 'w') do |f|
  f.puts "# x y"
  # t を 0 から 1 まで変化させて曲線上の点を計算
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
end

# plot "bezier.dat" index 0 with lines title "ベジエ曲線", "bezier.dat" index 1 with points title "制御点"
