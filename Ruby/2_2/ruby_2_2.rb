require 'csv'

class Organized_Data

    attr_accessor :temp, :humi, :co2

    def initialize()
        @temp = []
        @humi = []
        @co2 = []
    end

    def average_temp
        (@temp.sum / @temp.size).round(1)
    end

    def average_humi
        (@humi.sum / @humi.size).round(1)
    end

    def average_co2
        @co2.sum / @co2.size
    end

    def max_temp
        @temp.max
    end

    def min_temp
        @temp.min
    end

    def max_humi
        @humi.max
    end

    def min_humi
        @humi.min
    end 

    def max_co2
        @co2.max
    end

    def min_co2
        @co2.min
    end

    def median_temp
        sorted = @temp.sort
        mid_index = sorted.size / 2

        if sorted.size.odd?
            sorted[mid_index]
        else
            (sorted[mid_index - 1] + sorted[mid_index]) / 2.0
        end
    end
    def median_humi
        sorted = @humi.sort
        mid_index = sorted.size / 2

        if sorted.size.odd?
            sorted[mid_index]
        else
            (sorted[mid_index - 1] + sorted[mid_index]) / 2.0
        end
    end 

    def median_co2
        sorted = @co2.sort
        mid_index = sorted.size / 2

        if sorted.size.odd?
            sorted[mid_index]
        else
            (sorted[mid_index - 1] + sorted[mid_index]) / 2.0
        end
    end
        
    
end
    
    
def add_data_to_organized_data(data_file,target_organized_data)
    CSV.foreach(data_file){|row|
        temp_value = row[1].to_f    
        if temp_value > 0 && temp_value <= 35
            target_organized_data.temp.push(temp_value)
        end
        humi_value = row[2].to_f
        if humi_value > 0 && humi_value <= 100
            target_organized_data.humi.push(humi_value)
        end
        co2_value = row[3].to_i
        if co2_value > 0 && co2_value <= 2000  
            target_organized_data.co2.push(co2_value)
        end
    }
end


def batch_process_files(target_folder)
    monthly_data = {}

    target_files = Dir.glob(sprintf("%s/*.csv",target_folder))

    target_files.each{|file|
        month = File.basename(file)[0, 2]

        unless monthly_data.key?(target_folder+"_"+month)
            monthly_data[target_folder+"_"+month] = Organized_Data.new()
        end

        add_data_to_organized_data(file, monthly_data[target_folder+"_"+month])
    }

    monthly_data.each{|key, value|
        puts key 
        puts "  <温度>"
        puts "  平均温度：#{value.average_temp}"+"最大温度：#{value.max_temp}"+"最小温度：#{value.min_temp}"+"中央値：#{value.median_temp}"
        puts "  <湿度>"
        puts "  平均湿度：#{value.average_humi}"+"最大湿度：#{value.max_humi}"+"最小湿度：#{value.min_humi}"+"中央値：#{value.median_humi}"
        puts "  <CO2>"
        puts "  平均CO2：#{value.average_co2}"+"最大CO2：#{value.max_co2}"+"最小CO2：#{value.min_co2}"+"中央値：#{value.median_co2}"
    }
end



batch_process_files("2020")
batch_process_files("2021")




