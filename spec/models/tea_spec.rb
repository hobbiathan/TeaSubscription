require 'rails_helper'

RSpec.describe Tea, type: :model do
  context 'relationships' do
    it { should have_many :tea_subs }
    it { should have_many(:subscriptions).through(:tea_subs) }

  end

  context 'attributes' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :temperature }
    it { should validate_presence_of :brew_time }
  end
end
