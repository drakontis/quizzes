# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  role                   :integer
#

RSpec.describe User do

  subject { User.new(email: 'user@example.com') }

  it { should respond_to(:email) }

  it { should have_many(:taken_quizzes).dependent(:destroy) }

  it "#email returns a string" do
    expect(subject.email).to match 'user@example.com'
  end

  describe '#taken_quizzes_for_quiz' do
    subject { FactoryGirl.create :user }
    let(:quiz) { FactoryGirl.create :quiz }

    before do
      3.times do
        subject.taken_quizzes << TakenQuiz.new(quiz: quiz)
      end
    end

    it 'should return the taken_quizzes objects for a given quiz' do
      result = subject.taken_quizzes_for_quiz(quiz)
      expect(result.count).to eq 3

      expect(result.first.quiz).to eq quiz
      expect(result.second.quiz).to eq quiz
      expect(result.third.quiz).to eq quiz
    end
  end
end
