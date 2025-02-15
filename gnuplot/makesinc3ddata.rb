File.open('sinc3d.dat', 'w'){|f|
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


# splot "sinc3d.dat" using 1:2:3 with lines title "sinc3d"

#カラーマップを表示
#set pm3d
#set palette

#等高線を表示
#set cntrparam levels 20
#set cntrparam levels incremental -0.4,0.1,1

#Z軸全体を使う
#set ticslevel 0