# frozen_string_literal: true

require './budget_service'
require './budget_repo'
require './budget'
require 'date'

RSpec.describe BudgetService do
  subject { budget_service.query(start_date, end_date) }
  let(:budget_service) { BudgetService.new }

  describe '#query' do
    let(:budget_array) do
      [
        Budget.new('202303', 31000),
      ]
    end
    context '2023 march data budget: 31000' do
      before do
        allow(BudgetRepo).to receive_message_chain(:new, :get_all).and_return(budget_array)
      end
      context 'start_date/end_date both is 2023/03/01' do
        let(:start_date) { DateTime.new(2023, 3, 1) }
        let(:end_date) { DateTime.new(2023, 3, 1) }
        it { is_expected.to eq(1000) }
      end

      context 'start_date 2023/03/01, end_date 2023/03/02' do
        let(:start_date) { DateTime.new(2023, 3, 1) }
        let(:end_date) { DateTime.new(2023, 3, 2) }
        it { is_expected.to eq(2000) }
      end
    end
  end
end
