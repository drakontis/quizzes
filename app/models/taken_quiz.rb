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

  validates :user, presence: true
  validates :quiz, presence: true
end
