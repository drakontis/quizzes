# == Schema Information
#
# Table name: quizzes
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Quiz < ApplicationRecord
  has_many :taken_quizzes, dependent: :destroy
  has_many :questions,     dependent: :destroy
  accepts_nested_attributes_for :questions, allow_destroy: true

  validates :title, presence: true
end
