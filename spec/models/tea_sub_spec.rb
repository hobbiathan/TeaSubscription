require 'rails_helper'

RSpec.describe TeaSub, type: :model do
  context 'relationships' do
    it { should belong_to :customer }
  end
end
