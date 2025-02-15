require 'date'

# 初回勤務日を設定（例：2024年1月1日）
first_work_date = Date.new(2020, 1, 1)

# 今日の日付を取得
today = Date.today

# 初回勤務日から今日までの日数を計算
days_worked = (today - first_work_date).to_i

printf("初回勤務日: %s\n",first_work_date.strftime('%Y年%m月%d日'))
printf("今日の日付: %s\n",today.strftime('%Y年%m月%d日'))
printf("%s から %s までの暦日数は %d日\n",first_work_date,today,days_worked)
