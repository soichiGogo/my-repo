require 'date'

class Work_Data
    attr_reader :name, :work_date, :work_min
    def initialize(name, work_date, work_min)
        @name = name
        @work_date = work_date
        @work_min = work_min
    end
  
end

def parse_work_data_from_file(file_path, name, year)
  work_data = []
  
  File.foreach(file_path){|line|
    next unless line.match(/^\d{1,2}\/\d{1,2}/) # 日付で始まる行を探す

    date_str, in_time, out_time, *_rest = line.split#line.splitは、lineをスペースで分割して、その結果を配列に格納する
    date = Date.strptime("#{year}/#{date_str}", '%Y/%m/%d')
    in_hour, in_minute = in_time.split(':').map(&:to_i)
    out_hour, out_minute = out_time.split(':').map(&:to_i)

   
    work_minutes = (out_hour * 60 + out_minute) - (in_hour * 60 + in_minute)
    work_data.push(Work_Data.new(name, date, work_minutes))
  }
  work_data
end

def Totalling_Work_Time_by_Name_and_Month(work_data)
  totalled_work_data = work_data.group_by { |data| [data.name, data.work_date.strftime('%Y-%m')] }.map do |(name, month), data_array|
    {
      name: name,
      month: month,
      total_work_time: convert_minutes_to_hours_and_minutes(data_array.sum(&:work_min))
    }
  end

  totalled_work_data.each{|data|
    printf("%s  %s  %s\n",data[:name],data[:month],data[:total_work_time])
  }
end

def convert_minutes_to_hours_and_minutes(total_minutes)
    hours = total_minutes / 60
    minutes = total_minutes % 60
    sprintf("%dh %dmin",hours,minutes)
  end




file_path = 'kinmu_kitagawa2025_01Jan.txt'
name = '北川'
year = 2025
work_data = parse_work_data_from_file(file_path, name, year)

# 結果を表示
work_data.each{|data|
  printf("%s - %s - %s分\n",data.name,data.work_date,data.work_min)
}

Totalling_Work_Time_by_Name_and_Month(work_data)
