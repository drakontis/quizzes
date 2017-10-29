# == Schema Information
#
# Table name: answers
#
#  id            :integer          not null, primary key
#  taken_quiz_id :integer          not null
#  question_id   :integer          not null
#  choice_id     :integer          not null
#

class Answer < ApplicationRecord
  belongs_to :taken_quiz
  belongs_to :question
  belongs_to :choice

  validates :taken_quiz, presence: true
  validates :question,   presence: true
  validates :choice,     presence: true
  validates :choice, uniqueness: {scope: [:taken_quiz, :question]}
end
