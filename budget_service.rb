# frozen_string_literal: true

require 'date'
# Query to get time period budget: integer
class BudgetService
  def initialize
  end

  def query(start_date, end_date)
    array_of_budget = BudgetRepo.new.get_all
    budget_hash = generate_budget_hash(array_of_budget)

    if start_date.month == end_date.month
      budget_hash[start_date.strftime('%Y%m')] * ratio(start_date, end_date)
    elsif end_date.month != start_date.month
      start_date_month_budget(start_date, budget_hash) + end_date_month_budget(end_date, budget_hash) +
        whole_month_budget_between(start_date, end_date, budget_hash)
    end
  end

  private

  def ratio(start_date, end_date)
    partial_day = (end_date - start_date).to_i + 1
    days_in_month = last_day_in_month(start_date).day
    partial_day / days_in_month.to_f
  end

  def last_day_in_month(start_date)
    Date.new(start_date.strftime('%Y').to_i, start_date.strftime('%m').to_i, -1)
  end

  def first_day_in_month(start_date)
    Date.new(start_date.strftime('%Y').to_i, start_date.strftime('%m').to_i, 1)
  end

  def whole_month_budget_between(start_date, end_date, budget_hash)
    sum = 0
    date = start_date
    while date.next_month.strftime('%Y%m') != end_date.strftime('%Y%m')
      sum += budget_hash[date.next_month.strftime('%Y%m')]
      date = date.next_month
    end

    sum
  end

  def generate_budget_hash(array_of_budget)
    hash = {}
    array_of_budget.map do |budget|
      hash[budget.year_month] = budget.amount
    end

    hash
  end

  def start_date_month_budget(start_date, budget_hash)
    budget_hash[start_date.strftime('%Y%m')] * ratio(start_date, last_day_in_month(start_date))
  end

  def end_date_month_budget(end_date, budget_hash)
    budget_hash[end_date.strftime('%Y%m')] * ratio(first_day_in_month(end_date), end_date)
  end
end
