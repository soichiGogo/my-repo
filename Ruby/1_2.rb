require 'date'


def calculate_by_month(accountdata,selected_month)
    total_amount = 0
    accountdata.each{ |data|
        if data[0].year == selected_month[0] && data[0].month == selected_month[1]
            total_amount += data[2]
        end
    }
    sprintf("%04d年%02d月の合計金額は %d円です。",selected_month[0], selected_month[1], total_amount)
end

def calculate_by_item(accountdata,selected_item)
    total_amount = 0
    accountdata.each{ |data|
        if data[1] == selected_item
            total_amount += data[2]
        end
    }
    sprintf("勘定科目%sの合計金額は %d円です。",selected_item, total_amount)
end

def calculate_by_month_and_item(accountdata,selected_month,selected_item)
    total_amount = 0
    accountdata.each{ |data|
        if data[0].year == selected_month[0] && data[0].month == selected_month[1] && data[1] == selected_item
            total_amount += data[2]
        end
    }
    sprintf("勘定科目%sの%04d年%02d月の合計金額は %d円です。",selected_item, selected_month[0], selected_month[1], total_amount)
end

accountdata = []#[[Date, String, Integer]]

File.open("accountdata.csv", "r"){|f|
  f.each_with_index{|line|
    data = line.split(",") 
    accountdata.push([Date.strptime(data[0], "%Y-%m-%d"), data[1], data[2].to_i])
  }
}

exist_month = accountdata.map{ |data| [data[0].year,data[0].month] }.uniq
exist_item = accountdata.map{ |data| data[1] }.uniq

File.open("result_1_2.txt", "w"){|f|
    exist_month.each{ |month|
        f.puts calculate_by_month(accountdata,month)
    }
    exist_item.each{ |item|
        f.puts calculate_by_item(accountdata,item)
    }
}

