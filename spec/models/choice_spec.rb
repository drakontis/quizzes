require 'rails_helper'

RSpec.describe Choice, type: :model do
  it { should belong_to(:question) }

  it { should validate_presence_of(:statement) }
end
