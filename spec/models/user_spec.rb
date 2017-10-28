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

end
