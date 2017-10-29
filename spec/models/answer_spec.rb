# == Schema Information
#
# Table name: answers
#
#  id            :integer          not null, primary key
#  taken_quiz_id :integer          not null
#  question_id   :integer          not null
#  choice_id     :integer          not null
#

require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:taken_quiz) }
  it { should belong_to(:question)   }
  it { should belong_to(:choice)     }

  it { should validate_presence_of(:taken_quiz) }
  it { should validate_presence_of(:question)   }
  it { should validate_presence_of(:choice)     }

  it 'should not be valid when choice already exists for a quiz' do
    user = FactoryGirl.create(:user)
    quiz = FactoryGirl.create(:quiz)

    taken_quiz = TakenQuiz.new(user: user, quiz: quiz)
    taken_quiz.save!

    taken_quiz.answers << Answer.new(question: quiz.questions.first, choice: quiz.questions.first.choices.first)

    answer = Answer.new(taken_quiz: taken_quiz, question: quiz.questions.first, choice: quiz.questions.first.choices.first)
    expect(answer).not_to be_valid
    expect(answer.errors.full_messages).to include 'Choice has already been taken'
  end
end
