# == Schema Information
#
# Table name: quizzes
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Quiz, type: :model do
  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:taken_quizzes).dependent(:destroy) }

  it { should validate_presence_of(:title) }
end
