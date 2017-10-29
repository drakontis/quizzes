# == Schema Information
#
# Table name: quizzes
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :quiz do
    title "MyString"
    questions { [FactoryGirl.build(:question_1),
                 FactoryGirl.build(:question_2),
                 FactoryGirl.build(:question_3)] }
  end
end
