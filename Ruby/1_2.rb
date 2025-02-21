#月毎に仕分け
hash = {}
open("accountdata.csv", "r"){ |f|
    f.each{ |line|
        data = line.split(",")
        key = data[0][0,7] # 年月
        hash[key] = 0 if hash[key] == nil
        hash[key] += data[2].to_i
    }
}
#勘定科目毎に仕分け
open("accountdata.csv", "r"){ |f|
    f.each{ |line|
        data = line.split(",")
        key = data[1]
        hash[key] = 0 if hash[key] == nil
        hash[key] += data[2].to_i
    }
}
#txtファイルに出力
open("result_1_2.txt", "w"){ |f|
    hash.sort.each{ |k,v|
        f.puts "#{k}の合計金額は#{v}円です。"
    }
}
