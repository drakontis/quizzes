# == Schema Information
#
# Table name: choices
#
#  id          :integer          not null, primary key
#  question_id :integer          not null
#  statement   :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Choice, type: :model do
  it { should belong_to(:question) }

  it { should validate_presence_of(:statement) }
end
