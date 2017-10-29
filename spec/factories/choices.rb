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

FactoryGirl.define do
  factory :choice do
    question nil
    statement "MyString"

    factory :choice_1 do
      statement "Choice 1"
    end

    factory :choice_2 do
      statement "Choice 2"
    end

    factory :choice_3 do
      statement "Choice 3"
    end

    factory :choice_4 do
      statement "Choice 4"
    end

    factory :choice_5 do
      statement "Choice 5"
    end

    factory :choice_6 do
      statement "Choice 6"
    end

    factory :choice_7 do
      statement "Choice 7"
    end

    factory :choice_8 do
      statement "Choice 8"
    end

    factory :choice_9 do
      statement "Choice 9"
    end

    factory :choice_10 do
      statement "Choice 10"
    end

    factory :choice_11 do
      statement "Choice 11"
    end

    factory :choice_12 do
      statement "Choice 12"
    end
  end
end
