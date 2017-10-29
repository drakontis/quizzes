# == Schema Information
#
# Table name: taken_quizzes
#
#  id      :integer          not null, primary key
#  user_id :integer          not null
#  quiz_id :integer          not null
#

class TakenQuiz < ApplicationRecord
  belongs_to :user
  belongs_to :quiz
  has_many   :answers, dependent: :destroy

  validates :user, presence: true
  validates :quiz, presence: true

  def self.active_taken_quiz(quiz:, user:)
    TakenQuiz.where(quiz: quiz, user: user).select{ |taken_quiz| taken_quiz.active? }.first
  end

  def active?
    quiz.questions.count > answers.count
  end

  def next_question
    if answers.empty?
      quiz.questions.first
    else
      answers.map(&:question).max_by(&:id).next
    end
  end
end
