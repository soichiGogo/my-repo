require 'date'

first_work_day = Date.new(2020,1,12)
today = Date.today

difference = today - first_work_day

printf("%s から %s までの暦日数は %d 日\n", first_work_day, today, difference)