accountdata = [
    ["2025-01-01", "book", 1000],
    ["2025-02-02", "taxi", 2000],
    ["2025-01-03", "kosai", 3000],
    ["2025-03-01", "book", 1500],
    ["2025-02-02", "taxi", 2200],
    ["2026-01-16", "kosai", 3400],
    ["2026-06-16", "book", 3400],
    ["2026-08-16", "taxi", 3400],
    ["2027-07-16", "kosai", 3400],
    ["2027-08-16", "kosai", 3400],
    ["2027-08-23", "syokuji", 3400],
    ["2027-08-26", "kosai", 1300],
    ["2027-09-16", "kosai", 2300],
]

# 年月ごとの合計金額を計算
target = {}
accountdata.each{ |data|
    key = data[0][0,7] # 年月
    target[key] = 0 if target[key] == nil
    target[key] += data[2]
}
target.sort.each{ |k,v|
    puts "#{k}の合計金額は#{v}円です。"
}

# 勘定科目ごとの合計金額を計算
target = {}
accountdata.each{ |data|
    key = data[1]
    target[key] = 0 if target[key] == nil
    target[key] += data[2]
}
target.sort.each{ |k,v|
    puts "#{k}の合計金額は#{v}円です。"
}

# 年月ごとの合計金額を計算
target = {}
accountdata.each{ |data|
    key = data[0][0,7] + data[1]
    target[key] = 0 if target[key] == nil
    target[key] += data[2]
}
target.sort.each{ |k,v|
    puts "#{k}の合計金額は#{v}円です。"
}

