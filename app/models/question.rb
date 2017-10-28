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

class Question < ApplicationRecord
  belongs_to :quiz, optional: true
  has_many :choices, dependent: :destroy
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :choices, allow_destroy: true

  validates :prompt, presence: true

  def next
    quiz.questions.where("id > ?", id).first
  end
end
