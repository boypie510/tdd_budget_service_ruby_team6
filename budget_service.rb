# frozen_string_literal: true

require 'date'
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

    if start_date.month == end_date.month
      budget_hash[start_date.strftime('%Y%m')] * ratio(start_date, end_date)
    elsif end_date.month - start_date.month == 1
      budget_hash[start_date.strftime('%Y%m')] * ratio(start_date, last_day_in_month(start_date)) +
        budget_hash[end_date.strftime('%Y%m')] * ratio(first_day_in_month(end_date), end_date)
    end
  end

  private

  def ratio(start_date, end_date)
    # last_day_in_month = Date.new(2023, start_date.strftime('%m').to_i, -1)
    partial_day = (end_date - start_date).to_i + 1
    days_in_month = last_day_in_month(start_date).day.to_f
    partial_day / days_in_month
  end

  def last_day_in_month(start_date)
    Date.new(start_date.strftime('%Y').to_i, start_date.strftime('%m').to_i, -1)
  end

  def first_day_in_month(start_date)
    Date.new(start_date.strftime('%Y').to_i, start_date.strftime('%m').to_i, 1)
  end
end
