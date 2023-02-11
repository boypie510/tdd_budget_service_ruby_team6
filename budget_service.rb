# frozen_string_literal: true

# Query to get time period budget: integer
class BudgetService
  def initialize
  end

  def query(start_date, end_date)
    array_of_budget = BudgetRepo.new.get_all
    budget_hash = {}
    array_of_budget.map do |budget|
      budget_hash[budget.year_month] = budget.amount
    end

    # if start_date.month == end_date.month
    partial_day = (end_date - start_date).to_i + 1
    days_in_month = Date.new(2023, start_date.strftime('%m').to_i, -1).day.to_f
    ratio = partial_day / days_in_month
    budget_hash[end_date.strftime('%Y%m')] * ratio
  end
end
