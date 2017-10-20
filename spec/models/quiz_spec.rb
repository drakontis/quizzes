require 'rails_helper'

RSpec.describe Quiz, type: :model do
  it { should have_many(:questions).dependent(:destroy) }

  it { should validate_presence_of(:title) }
end
