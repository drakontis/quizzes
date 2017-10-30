require 'rails_helper'
RSpec.describe StatsHelper, :type => :helper do

  let(:user){ FactoryGirl.create :user }
  let(:user_2){ FactoryGirl.create :user, email: "test2@example.com" }
  let(:quiz){ FactoryGirl.create :quiz }

  before do
    taken_quiz_1 = TakenQuiz.new(quiz: quiz, user: user)
    taken_quiz_1.answers << Answer.new(taken_quiz: taken_quiz_1,
                                       question: quiz.questions.first,
                                       choice: quiz.questions.first.choices.first)
    taken_quiz_1.answers << Answer.new(taken_quiz: taken_quiz_1,
                                       question: quiz.questions.second,
                                       choice: quiz.questions.second.choices.first)
    taken_quiz_1.answers << Answer.new(taken_quiz: taken_quiz_1,
                                       question: quiz.questions.second,
                                       choice: quiz.questions.third.choices.first)
    taken_quiz_1.save!

    taken_quiz_2 = TakenQuiz.new(quiz: quiz, user: user)
    taken_quiz_2.answers << Answer.new(taken_quiz: taken_quiz_2,
                                       question: quiz.questions.first,
                                       choice: quiz.questions.first.choices.second)
    taken_quiz_2.answers << Answer.new(taken_quiz: taken_quiz_2,
                                       question: quiz.questions.second,
                                       choice: quiz.questions.second.choices.first)
    taken_quiz_2.save!

    taken_quiz_3 = TakenQuiz.new(quiz: quiz, user: user_2)
    taken_quiz_3.answers << Answer.new(taken_quiz: taken_quiz_1,
                                       question: quiz.questions.first,
                                       choice: quiz.questions.first.choices.first)
    taken_quiz_3.answers << Answer.new(taken_quiz: taken_quiz_1,
                                       question: quiz.questions.second,
                                       choice: quiz.questions.second.choices.second)
    taken_quiz_3.answers << Answer.new(taken_quiz: taken_quiz_1,
                                       question: quiz.questions.second,
                                       choice: quiz.questions.third.choices.first)
    taken_quiz_3.save!
  end

  describe '#question_data' do
    it 'should return the number of the selections for each choice of all users' do
      expect(helper.question_data(quiz.questions.first)).to eq [2, 1, 0, 0]
    end

    it 'should return the number of the selections for a specific user' do
      expect(helper.question_data(quiz.questions.first, user_2)).to eq [1, 0, 0, 0]
    end
  end

  describe '#colors' do
    it 'should return the list of colors' do
      expect(helper.colors).to eq ['green',
                                   'red',
                                   'blue',
                                   'yellow',
                                   'orange',
                                   'grey',
                                   'PaleVioletRed',
                                   'LawnGreen',
                                   'Indigo',
                                   'RoyalBlue']
    end
  end

  describe '#datasets_for' do
    it 'should return the datasets for the quiz for all users' do
      expect(helper.datasets_for(quiz)).to eq [{label: "Question 1",
                                                backgroundColor: "green",
                                                borderColor: "black",
                                                data: [2, 1, 0, 0]},
                                               {label: "Question 2",
                                                backgroundColor: "red",
                                                borderColor: "black",
                                                data: [2, 1, 0, 0]},
                                               {label: "Question 3",
                                                backgroundColor: "blue",
                                                borderColor: "black",
                                                data: [2, 0, 0, 0]}]
    end

    it 'should return the datasets for the quiz for specific user' do
      expect(helper.datasets_for(quiz, user_2)).to eq [{label: "Question 1",
                                                        backgroundColor: "green",
                                                        borderColor: "black",
                                                        data: [1, 0, 0, 0]},
                                                       {label: "Question 2",
                                                        backgroundColor: "red",
                                                        borderColor: "black",
                                                        data: [0, 1, 0, 0]},
                                                       {label: "Question 3",
                                                        backgroundColor: "blue",
                                                        borderColor: "black",
                                                        data: [1, 0, 0, 0]}]
    end
  end
end
