require 'date'

class Accountdata
  VALID_ITEMS = ['book', 'taxi', 'kosai']
  
  attr_accessor :date, :item, :amount
  
  def initialize(date:, item:, amount:)
    @date = Date.parse(date)
    if VALID_ITEMS.include?(item)
      @item = item
    else
      raise ArgumentError, "項目は #{VALID_ITEMS.join(', ')} のいずれかである必要があります"
    end
    @amount = amount
  end
end

# accountdata = [Accountdata.new(date: "2025-01-01", item: "book", amount: 1000),
#               Accountdata.new(date: "2025-02-02", item: "taxi", amount: 2000),
#               Accountdata.new(date: "2025-01-03", item: "kosai", amount: 3000),
#               Accountdata.new(date: "2025-03-01", item: "book", amount: 1500),
#               Accountdata.new(date: "2025-02-02", item: "taxi", amount: 2200),
#               Accountdata.new(date: "2025-01-16", item: "kosai", amount: 3400),
#               Accountdata.new(date: "2025-01-16", item: "book", amount: 3400),
#               Accountdata.new(date: "2025-01-16", item: "taxi", amount: 3400),
#               Accountdata.new(date: "2025-01-16", item: "kosai", amount: 3400),
#               ]

accountdata = []
accountdata.push(Accountdata.new(date: "2025-01-01", item: "book", amount: 1000))
accountdata.push(Accountdata.new(date: "2025-02-02", item: "taxi", amount: 2000))
accountdata.push(Accountdata.new(date: "2025-01-03", item: "kosai", amount: 3000))
accountdata.push(Accountdata.new(date: "2025-03-01", item: "book", amount: 1500))
accountdata.push(Accountdata.new(date: "2025-02-02", item: "taxi", amount: 2200))
accountdata.push(Accountdata.new(date: "2025-01-16", item: "kosai", amount: 3400))
accountdata.push(Accountdata.new(date: "2025-01-16", item: "book", amount: 3400))
accountdata.push(Accountdata.new(date: "2025-01-16", item: "taxi", amount: 3400))
accountdata.push(Accountdata.new(date: "2025-01-16", item: "kosai", amount: 3400))


def calculate_by_month(accountdata,selected_month)
    monthly_data = accountdata.select { |accountdata| accountdata.date.month == selected_month }
    total_amount = monthly_data.sum { |accountdata| accountdata.amount }
    sprintf("%02d月の合計金額は %d円です。",selected_month, total_amount)
end

def calculate_by_item(accountdata,selected_item)
    itemly_data = accountdata.select { |accountdata| accountdata.item == selected_item }
    total_amount = itemly_data.sum { |accountdata| accountdata.amount }
    sprintf("勘定科目%sの合計金額は %d円です。",selected_item, total_amount)
end

def calculate_by_month_and_item(accountdata,selected_month ,selected_item)
  itemly_data = accountdata.select { |accountdata| accountdata.item == selected_item && accountdata.date.month == selected_month }
  total_amount = itemly_data.sum { |accountdata| accountdata.amount }
  sprintf("勘定科目%sの%02d月の合計金額は %d円です。",selected_item, selected_month, total_amount)
end

puts calculate_by_month(accountdata,1)
puts calculate_by_item(accountdata,"book")
puts calculate_by_month_and_item(accountdata,1,"book")