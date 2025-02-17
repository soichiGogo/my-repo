def make_average(data)
    sum = 0
    data.each{|value|
        sum += value
    }
    return sum / data.count
end
def make_max(data)
    max = data[0]
    data.each{|value|
        max = value if value > max
    }
    return max
end
def make_min(data)
    min = data[0]
    data.each{|value|
        min = value if value < min
    }
    return min
end
def make_median(data)
    sorted = data.sort
    if data.count % 2 == 0
        return (sorted[data.count / 2 - 1] + sorted[data.count / 2]) / 2
    else
        return sorted[(data.count - 1) / 2]
    end
end


target_dirs = ["2020","2021"]

data_with_year_and_month = {}#{"01"=>{"temp"=>[], "humi"=>[], "co2"=>[]}, "02"=>{"temp"=>[], "humi"=>[], "co2"=>[]}, ...}

target_dirs.each{ |target_dir|
    Dir.foreach(target_dir){ |file|
        next unless File.extname(file).downcase == ".csv"
        
        File.open(File.join(target_dir, file), "r"){|f|
            f.each_line{ |line|
                data = line.split(",")
                next if 0 > data[1].to_f || data[1].to_f > 40
                next if 0 > data[2].to_f || data[2].to_f > 100
                next if 0 > data[3].to_i || data[3].to_i > 2000

                month = file[0,2]
                month_with_year = sprintf("%s%s", target_dir, month)

                data_with_year_and_month[month_with_year] ||= { temp: [], humi: [], co2: [] }
                    
                data_with_year_and_month[month_with_year][:temp].push(data[1].to_f)
                data_with_year_and_month[month_with_year][:humi].push(data[2].to_f)
                data_with_year_and_month[month_with_year][:co2].push(data[3].to_i)
            }
        }
    }
}

data_with_year_and_month.keys.sort.each{ |year_and_month|

    data = data_with_year_and_month[year_and_month]
    
    printf("%s年%s月\n", year_and_month[0,4], year_and_month[4,2])
    printf(" 平均気温: %f", make_average(data[:temp]))
    printf(" 最高気温: %f", make_max(data[:temp]))
    printf(" 最低気温: %f", make_min(data[:temp]))
    printf("中央値: %f\n", make_median(data[:temp]))
    printf(" 平均湿度: %f", make_average(data[:humi]))
    printf(" 最高湿度: %f", make_max(data[:humi]))
    printf(" 最低湿度: %f", make_min(data[:humi]))
    printf("中央値: %f\n", make_median(data[:humi]))
    printf(" 平均co2: %f", make_average(data[:co2]))
    printf(" 最高co2: %f", make_max(data[:co2]))
    printf(" 最低co2: %f", make_min(data[:co2]))
    printf("中央値: %f\n", make_median(data[:co2]))
}