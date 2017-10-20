class Choice < ApplicationRecord
  belongs_to :question, optional: true

  validates :statement, presence: true
end
