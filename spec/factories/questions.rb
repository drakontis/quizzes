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

FactoryGirl.define do
  factory :question do
    quiz nil
    prompt "MyString"

    factory :question_1 do
      choices {[FactoryGirl.build(:choice_1),
                FactoryGirl.build(:choice_2),
                FactoryGirl.build(:choice_3),
                FactoryGirl.build(:choice_4)]}
    end

    factory :question_2 do
      choices {[FactoryGirl.build(:choice_5),
                FactoryGirl.build(:choice_6),
                FactoryGirl.build(:choice_7),
                FactoryGirl.build(:choice_8)]}
    end

    factory :question_3 do
      choices {[FactoryGirl.build(:choice_9),
                FactoryGirl.build(:choice_10),
                FactoryGirl.build(:choice_11),
                FactoryGirl.build(:choice_12)]}
    end
  end
end
