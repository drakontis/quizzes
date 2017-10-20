class Question < ApplicationRecord
  belongs_to :quiz, optional: true
  has_many :choices, dependent: :destroy
  accepts_nested_attributes_for :choices, allow_destroy: true

  validates :prompt, presence: true
end
