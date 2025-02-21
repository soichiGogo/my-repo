`ls -1 */*.csv`.split.each{ |file|
    `mkdir -p #{sprintf("%s_command",File.dirname(file))}`
    make_command_file_name = sprintf("%s/#{File.basename(file, '.csv')}.gp",sprintf("%s_command",File.dirname(file)))
    open(make_command_file_name, "w"){ |f2|
        f2.puts "set terminal svg"
        f2.puts "set output '#{File.basename(file, '.csv')}.svg'"
        f2.puts "set xdata time"
        f2.puts "set timefmt '%H:%M:%S'"
        f2.puts "set format x '%H:%M'"
        f2.puts "set xlabel '時間'"
        f2.puts "set ylabel '温度(°C) / 湿度(%)'"
        f2.puts "set yrange [0:40]"
        f2.puts "set ytics ('0°C / 0%%' 0, '10°C / 25%%' 10, '20°C / 50%%' 20, '30°C / 75%%' 30, '40°C / 100%%' 40)"
        f2.puts "set y2label 'CO2 (ppm)'"
        f2.puts "set y2range [0:2000]"
        f2.puts "set y2tics"
        f2.puts "set title '#{File.basename(file, '.csv')}'"
        f2.puts "set grid"
        f2.puts "plot '#{file}' using 1:2 with lines title '温度' axis x1y1, \
        '#{file}' using 1:($3*40/100) with lines title '湿度' axis x1y1, \
        '#{file}' using 1:4 with lines title 'CO2' axis x1y2"
    }
    `gnuplot #{make_command_file_name}`
    result_dir = sprintf("%s_result",File.dirname(file))
    `mkdir -p #{result_dir}`
    `mv #{File.basename(file, '.csv')}.svg #{result_dir}`
}