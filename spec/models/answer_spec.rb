# == Schema Information
#
# Table name: answers
#
#  id            :integer          not null, primary key
#  taken_quiz_id :integer          not null
#  question_id   :integer          not null
#  choice_id     :integer          not null
#

require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should belong_to(:taken_quiz) }
  it { should belong_to(:question)   }
  it { should belong_to(:choice)     }

  it { should validate_presence_of(:taken_quiz) }
  it { should validate_presence_of(:question)   }
  it { should validate_presence_of(:choice)     }
end
