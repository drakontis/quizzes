# == Schema Information
#
# Table name: choices
#
#  id          :integer          not null, primary key
#  question_id :integer          not null
#  statement   :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Choice < ApplicationRecord
  belongs_to :question, optional: true

  validates :statement, presence: true
end
