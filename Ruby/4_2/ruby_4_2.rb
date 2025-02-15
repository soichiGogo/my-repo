

def generate_plot_commands
    <<~GNUPLOT
      set terminal png
      set output 'servomotor_4_2.png'  
      
      set xlabel 'Time'
      set ylabel 'Angle (°)'
      set xrange [0:1]
      set yrange [0:180]
      set xtics 0.1
      set samples 20
      set title 'Servo Motor Angle'

      
      plot 180/(1+exp(-15*(x-0.5))) with lp title "BySigmoid", \
           90*(1-cos(pi*x)) with lp title 'ByCos'
    GNUPLOT
end

File.write("plot_commands.gp", generate_plot_commands)
system("gnuplot plot_commands.gp")

File.delete("plot_commands.gp")