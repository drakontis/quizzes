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

  it 'should return the questions ordered by id' do
    quiz_1 = FactoryGirl.create(:quiz, title: 'Test Quiz 1', questions: [])
    quiz_2 = FactoryGirl.create(:quiz, title: 'Test Quiz 2', questions: [])

    question_1 = FactoryGirl.create(:question, prompt: 'Test Question 1', quiz: quiz_1)
    question_2 = FactoryGirl.create(:question, prompt: 'Test Question 2', quiz: quiz_1)
    question_3 = FactoryGirl.create(:question, prompt: 'Test Question 3', quiz: quiz_1)

    quiz_2.questions << question_3
    quiz_2.save!
    quiz_2.questions << question_1
    quiz_2.save!
    quiz_2.questions << question_2
    quiz_2.save!

    quiz_2.reload

    expect(quiz_2.questions.first).to eq question_1
    expect(quiz_2.questions.second).to eq question_2
    expect(quiz_2.questions.third).to eq question_3
  end
end
