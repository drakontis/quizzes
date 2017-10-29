# == Schema Information
#
# Table name: taken_quizzes
#
#  id      :integer          not null, primary key
#  user_id :integer          not null
#  quiz_id :integer          not null
#

require 'rails_helper'

RSpec.describe TakenQuiz, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:quiz) }
  it { should have_many(:answers).dependent(:destroy) }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:quiz) }
end
