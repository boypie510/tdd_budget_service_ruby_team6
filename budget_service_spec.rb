# frozen_string_literal: true

require './budget_service'
require 'date'

RSpec.describe BudgetService do
  subject { budget_service.query(start_date, end_date) }
  let(:budget_service) { BudgetService.new }

  describe '#query' do
    let(:start_date) { DateTime.new(2023, 3, 1) }
    let(:end_date) { DateTime.new(2023, 3, 1) }
    context 'get 1000' do
      it { is_expected.to eq(1000) }
    end
  end
end
