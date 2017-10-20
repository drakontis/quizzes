require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should belong_to(:quiz) }
  it { should have_many(:choices).dependent(:destroy) }

  it { should validate_presence_of(:prompt) }
end
