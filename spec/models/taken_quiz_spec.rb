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

  describe '#active_taken_quiz' do
    it 'should return the first active taken quiz' do
      quiz = FactoryGirl.create :quiz, title: 'Quiz 1'
      user = FactoryGirl.create :user

      taken_quiz_1 = TakenQuiz.new(quiz: quiz, user: user)
      taken_quiz_1.answers << Answer.new(taken_quiz: taken_quiz_1,
                                         question: quiz.questions.first,
                                         choice: quiz.questions.first.choices.first)
      taken_quiz_1.answers << Answer.new(taken_quiz: taken_quiz_1,
                                         question: quiz.questions.second,
                                         choice: quiz.questions.second.choices.first)
      taken_quiz_1.answers << Answer.new(taken_quiz: taken_quiz_1,
                                         question: quiz.questions.second,
                                         choice: quiz.questions.second.choices.first)
      taken_quiz_1.save!

      taken_quiz_2 = TakenQuiz.new(quiz: quiz, user: user)
      taken_quiz_2.answers << Answer.new(taken_quiz: taken_quiz_2,
                                         question: quiz.questions.first,
                                         choice: quiz.questions.first.choices.first)
      taken_quiz_2.answers << Answer.new(taken_quiz: taken_quiz_2,
                                         question: quiz.questions.second,
                                         choice: quiz.questions.second.choices.first)
      taken_quiz_2.save!

      expect(TakenQuiz.active_taken_quiz(quiz: quiz, user: user)).to eq taken_quiz_2
    end

    it 'should return nil if there are no active quizzes' do
      quiz = FactoryGirl.create :quiz, title: 'Quiz 1'
      user = FactoryGirl.create :user

      taken_quiz_1 = TakenQuiz.new(quiz: quiz, user: user)
      taken_quiz_1.answers << Answer.new(taken_quiz: taken_quiz_1,
                                         question: quiz.questions.first,
                                         choice: quiz.questions.first.choices.first)
      taken_quiz_1.answers << Answer.new(taken_quiz: taken_quiz_1,
                                         question: quiz.questions.second,
                                         choice: quiz.questions.second.choices.first)
      taken_quiz_1.answers << Answer.new(taken_quiz: taken_quiz_1,
                                         question: quiz.questions.third,
                                         choice: quiz.questions.third.choices.first)
      taken_quiz_1.save!

      expect(TakenQuiz.active_taken_quiz(quiz: quiz, user: user)).to be_nil
    end
  end

  describe '#active?' do
    it 'should be active if the answers are less than the questions' do
      quiz = FactoryGirl.create :quiz, title: 'Quiz 1'
      user = FactoryGirl.create :user

      taken_quiz = TakenQuiz.new(quiz: quiz, user: user)
      taken_quiz.answers << Answer.new(taken_quiz: taken_quiz,
                                         question: quiz.questions.first,
                                         choice: quiz.questions.first.choices.first)
      taken_quiz.answers << Answer.new(taken_quiz: taken_quiz,
                                         question: quiz.questions.second,
                                         choice: quiz.questions.second.choices.first)
      taken_quiz.save!

      expect(taken_quiz.active?).to be_truthy
    end

    it 'should not be active if the number of the answers is equal to the number of the questions' do
      quiz = FactoryGirl.create :quiz, title: 'Quiz 1'
      user = FactoryGirl.create :user

      taken_quiz = TakenQuiz.new(quiz: quiz, user: user)
      taken_quiz.answers << Answer.new(taken_quiz: taken_quiz,
                                       question: quiz.questions.first,
                                       choice: quiz.questions.first.choices.first)
      taken_quiz.answers << Answer.new(taken_quiz: taken_quiz,
                                       question: quiz.questions.second,
                                       choice: quiz.questions.second.choices.first)
      taken_quiz.answers << Answer.new(taken_quiz: taken_quiz,
                                       question: quiz.questions.third,
                                       choice: quiz.questions.third.choices.first)
      taken_quiz.save!

      expect(taken_quiz.active?).to be_falsey
    end
  end

  describe '#next_question' do
    it 'should return the first question if there are no answers' do
      quiz = FactoryGirl.create :quiz, title: 'Quiz 1'
      user = FactoryGirl.create :user

      taken_quiz = TakenQuiz.new(quiz: quiz, user: user)
      taken_quiz.save!

      expect(taken_quiz.next_question).to eq quiz.questions.first
    end

    it 'should return the next question' do
      quiz = FactoryGirl.create :quiz, title: 'Quiz 1'
      user = FactoryGirl.create :user

      taken_quiz = TakenQuiz.new(quiz: quiz, user: user)
      taken_quiz.answers << Answer.new(taken_quiz: taken_quiz,
                                       question: quiz.questions.first,
                                       choice: quiz.questions.first.choices.first)
      taken_quiz.save!

      expect(taken_quiz.next_question).to eq quiz.questions.second
    end
  end
end
