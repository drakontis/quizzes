# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  quiz_id    :integer          not null
#  prompt     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should belong_to(:quiz) }
  it { should have_many(:choices).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }

  it { should validate_presence_of(:prompt) }

  describe '#next' do
    it 'should return the next question' do
      quiz_1 = FactoryGirl.create(:quiz, title: 'Test Quiz 1')
      quiz_2 = FactoryGirl.create(:quiz, title: 'Test Quiz 2')

      question_1 = FactoryGirl.create(:question, prompt: 'Test Question 1', quiz: quiz_1)
      question_2 = FactoryGirl.create(:question, prompt: 'Test Question 2', quiz: quiz_1)
      question_3 = FactoryGirl.create(:question, prompt: 'Test Question 3', quiz: quiz_1)

      quiz_2.questions << question_3
      quiz_2.save!
      quiz_2.questions << question_1
      quiz_2.save!
      quiz_2.questions << question_2
      quiz_2.save!

      expect(question_2.next).to eq question_3
    end
  end
end
