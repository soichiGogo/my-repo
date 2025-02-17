filename = "kinmu_kitagawa2025_01Jan.txt"

# 正規表現パターンの解説:
# ^kinmu_       : ファイル名は "kinmu_" から始まる
# ([a-zA-Z]+)   : 英字のみを対象として名前部分のキャプチャ (kitagawa)
# (\d{4}_\d{2}) : 4桁の数字、アンダースコア、2桁の数字 (2025_01)
# [A-Za-z]+     : そのあと、アルファベットが1文字以上（例: Jan）
# \.txt$        : 最後に ".txt" で終わる

pattern = /^kinmu_([a-zA-Z]+)(\d{4}_\d{2})[A-Za-z]+\.txt$/

match_data = filename.match(pattern)
name   = match_data[1]
date   = match_data[2]

File.open(filename, "r"){|f|
    total = 0
    f.each_line{ |line|
        next unless line.match(/^\d{1,2}\/\d{1,2}/)

        date_str, in_time, out_time, *_rest = line.split
        in_time = in_time.split(":").map(&:to_i)
        out_time = out_time.split(":").map(&:to_i)
        total += out_time[0] * 60 + out_time[1] - (in_time[0] * 60 + in_time[1])
    }
    hours = total / 60
    min = total % 60
    printf("%s  %s  %dh %dmin\n", name, date, hours, min)
}

