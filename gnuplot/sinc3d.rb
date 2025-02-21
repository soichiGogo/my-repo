open('sinc3d.dat', 'w'){|f|
    f.puts "# x y z"
    50.times{|i|
        50.times{|j|
            x = i*8*Math::PI/50-4*Math::PI
            y = j*8*Math::PI/50-4*Math::PI
            r = Math.sqrt(x**2 + y**2)
            if r == 0
                z = 1
            else
                z = Math.sin(r)/r
            end
            f.printf("%f %f %f\n", x, y, z)
        }
        # 3Dプロットの場合各x座標のブロックの後に空行を入れる
        f.printf("\n")
    }
}

open("command_sinc3d.txt", "w"){|f|
  f.puts "set terminal png"
  f.puts "set output 'sinc3d.png'"
  f.puts "set xlabel 'x'"
  f.puts "set ylabel 'y'"
  f.puts "set zlabel 'z'"
  f.puts "set pm3d"
  f.puts "set palette"
  f.puts "set cntrparam levels 20"
  f.puts "set cntrparam levels incremental -0.4,0.1,1"
  f.puts "set ticslevel 0"
  f.puts "splot 'sinc3d.dat' using 1:2:3 with lines title 'sinc'"
}

`gnuplot command_sinc3d.txt`
