class Budget
  attr_reader :year_month, :amount

  def initialize(year_month, amount)
    @year_month = year_month
    @amount = amount
  end
end
