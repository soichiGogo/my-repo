require 'date'
require 'csv'

class Accountdata
  
  attr_accessor :date, :item, :amount
  
  def initialize(date:, item:, amount:)
    @date = Date.parse(date)
    @item = item
    @amount = amount
  end
end

def load_accountdata_from_csv(file_path)
    accountdata = []  
    CSV.foreach(file_path, col_sep: ' ', headers: true){|row| 
      next if row['date'].nil? || row['date'].strip.empty?  # dateがnilまたは空の場合はスキップ
      accountdata.push(Accountdata.new(               
        date: row['date'],      
        item: row['item'],      
        amount: row['amount'].to_i  
      ))
    }
    return accountdata  
end


def calculate_by_month(accountdata,selected_year,selected_month)
    monthly_data = accountdata.select { |accountdata| accountdata.date.year == selected_year && accountdata.date.month == selected_month }
    total_amount = monthly_data.sum { |accountdata| accountdata.amount }
    return sprintf("%04d年%02d月の合計金額は %d円です。",selected_year, selected_month, total_amount)
end

def calculate_by_item(accountdata,selected_item)
    itemly_data = accountdata.select { |accountdata| accountdata.item == selected_item }
    total_amount = itemly_data.sum { |accountdata| accountdata.amount }
    return sprintf("勘定科目%sの合計金額は %d円です。",selected_item, total_amount)
end

def calculate_by_month_and_item(accountdata,selected_year,selected_month ,selected_item)
  itemly_data = accountdata.select { |accountdata| accountdata.item == selected_item && accountdata.date.year == selected_year && accountdata.date.month == selected_month }
  total_amount = itemly_data.sum { |accountdata| accountdata.amount }
  return sprintf("勘定科目%sの%04d年%02d月の合計金額は %d円です。",selected_item, selected_year, selected_month, total_amount)
end

# accountdataのitemの種類の数を求める
def count_unique_items(accountdata)
  unique_items = accountdata.map(&:item).uniq
  return unique_items.count
end

accountdata = load_accountdata_from_csv('accountdata.csv')

File.open('result.txt', 'w'){|file|
  accountdata.map(&:date).map(&:year).uniq.each{|year|
    12.times{|i|
      file.puts calculate_by_month(accountdata, year, i+1)
    }
  }

  accountdata.map(&:item).uniq.each{|item|
    file.puts calculate_by_item(accountdata, item)
  }
}
