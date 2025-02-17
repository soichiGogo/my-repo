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
accountdata.push([Date.new(2025,1,1), "book", 1000],
                [Date.new(2025,2,2), "taxi", 2000],
                [Date.new(2025,1,3), "kosai", 3000],
                [Date.new(2025,3,1), "book", 1500],
                [Date.new(2025,2,2), "taxi", 2200],
                [Date.new(2026,1,16), "kosai", 3400],
                [Date.new(2026,6,16), "book", 3400],
                [Date.new(2026,8,16), "taxi", 3400],
                [Date.new(2027,7,16), "kosai", 3400],
                [Date.new(2027,8,16), "kosai", 3400],
                [Date.new(2027,8,23), "syokuji", 3400],
                [Date.new(2027,8,26), "kosai", 1300],
                [Date.new(2027,9,16), "kosai", 2300],
                [Date.new(2027,9,16), "textbook", 3400],
                )

exist_month = accountdata.map{ |data| [data[0].year,data[0].month] }.uniq
exist_item = accountdata.map{ |data| data[1] }.uniq

exist_month.each{ |month|
    puts calculate_by_month(accountdata,month)
}
exist_item.each{ |item|
    puts calculate_by_item(accountdata,item)
}

