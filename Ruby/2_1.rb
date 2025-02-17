target_dir = "2021"

Dir.foreach(target_dir){|file|
    next if file == '.' || file == '..'

    title_name = sprintf("%s-%s",target_dir,File.basename(file, '.csv'))

    IO.popen("gnuplot", "w"){|gp|
        commands = <<~GNUPLOT
          set terminal svg
          set output '#{title_name}.svg'
          set xdata time
          set timefmt '%H:%M:%S'
          set format x '%H:%M'
          set xlabel '時間'
          set ylabel '温度(°C) / 湿度(%)'
          set yrange [0:40]
          set ytics ('0°C / 0%%' 0, '10°C / 25%%' 10, '20°C / 50%%' 20, '30°C / 75%%' 30, '40°C / 100%%' 40)
          set y2label 'CO2 (ppm)'
          set y2range [0:2000]
          set y2tics
          set title '#{title_name}'
          set grid
          plot '#{File.join(target_dir, file)}' using 1:2 with lines title '温度' axis x1y1, \
               '#{File.join(target_dir, file)}' using 1:($3*40/100) with lines title '湿度' axis x1y1, \
               '#{File.join(target_dir, file)}' using 1:4 with lines title 'CO2' axis x1y2
        GNUPLOT

        gp.puts commands
    }
    
    result_dir = sprintf("%s_2_svg",target_dir)
    Dir.mkdir(result_dir) unless Dir.exist?(result_dir)
    `mv #{title_name}.svg #{result_dir}`
}
