require 'csv'
require 'fileutils'  


def generate_plot_commands(title_name)
    <<~GNUPLOT
      set terminal svg 
      set output 'temp.svg'  # 一時的なSVG名
      set xdata time
      set timefmt '%H:%M:%S'
      set format x '%H:%M'
      set xlabel 'Time'
      
      set ylabel 'Temperature (°C) / Humidity (%)'
      set yrange [0:40]
      set ytics ('0°C / 0%%' 0, '10°C / 25%%' 10, '20°C / 50%%' 20, '30°C / 75%%' 30, '40°C / 100%%' 40)
      
      
      set y2label 'CO2 (ppm)'
      set y2range [0:2000]
      set y2tics
      
      set title '#{title_name}'
      set grid
      
      plot 'temp_data.dat' using 1:2 with lines title 'Temperature' axis x1y1, \
           'temp_data.dat' using 1:($3*40/100) with lines title 'Humidity' axis x1y1, \
           'temp_data.dat' using 1:4 with lines title 'CO2' axis x1y2
    GNUPLOT
end

# データを一時ファイルに書き出す
def write_temp_data(data_file)
    File.open("temp_data.dat", "w"){|f|
      CSV.foreach(data_file){|row|
        time = row[0]
        temp = row[1]
        humidity = row[2]
        co2 = row[3]
        f.printf("%s %s %s %s\n",time, temp, humidity, co2)
      }
    }
  end


def batch_process_files(target_folder)
    # 出力用ディレクトリの作成
    output_dir = sprintf("%s_svg",target_folder)
    FileUtils.mkdir_p(output_dir) unless Dir.exist?(output_dir)
    
    # 処理対象のファイルを取得
    target_files = Dir.glob(sprintf("%s/*.csv",target_folder))
    
    # 各ファイルに対して処理を実行
    target_files.each{|file|
      # ファイルごとの処理
      write_temp_data(file)
      File.write("plot_commands.gp", generate_plot_commands(sprintf("%s-%s",target_folder,File.basename(file, '.csv'))))
      system("gnuplot plot_commands.gp")
      
      # SVGファイルを指定のディレクトリに移動
      output_file = sprintf("%s/%s.svg",output_dir,File.basename(file, '.csv'))
      FileUtils.mv('temp.svg', output_file)
      
      # 一時ファイルの削除
      File.delete("temp_data.dat")
      File.delete("plot_commands.gp")
    }
end

batch_process_files("2020")




