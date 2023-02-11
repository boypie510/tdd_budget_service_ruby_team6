# frozen_string_literal: true

# Query to get time period budget: integer
class BudgetService
  def initialize
  end

  def query(start_date, end_date)
    budget_array = BudgetRepo.new.get_all
    budget = budget_array[0]
    partial_day = (end_date - start_date).to_i + 1
    days_in_month = Date.new(2023, 3, -1).day.to_f
    ratio = partial_day / days_in_month
    budget.amount * ratio
  end
end
