include Warden::Test::Helpers
Warden.test_mode!

# Feature: Quizzes list
#   As a user
#   I want to see the quizzes list
RSpec.feature 'Quizzes index page', :devise do
  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Show the list of quizzes
  #   Given I am signed in
  #   When I visit the quizzes index page
  #   Then I see list of the available quizzes
  scenario 'user sees the list of quizzes' do
    user = FactoryGirl.create(:user, :admin)
    quiz_1 = FactoryGirl.create(:quiz, title: 'Quiz 1')
    quiz_2 = FactoryGirl.create(:quiz, title: 'Quiz 2')

    login_as(user, scope: :user)
    visit quizzes_path
    expect(page).to have_content 'Quizzes'

    # Header
    expect(page.find('table thead tr th:nth-child(1)').text).to eq '#'
    expect(page.find('table thead tr th:nth-child(2)').text).to eq 'Title'
    expect(page.find('table thead tr th:nth-child(3)').text).to eq 'Taken'
    expect(page.find('table thead tr th:nth-child(4)').text).to eq ''

    # First quiz
    expect(page.find('table tbody tr:nth-child(1) td:nth-child(1)').text).to eq '1'
    expect(page.find('table tbody tr:nth-child(1) td:nth-child(2)').text).to eq quiz_1.title
    expect(page.find('table tbody tr:nth-child(1) td:nth-child(3)').text).to eq '0 times'
    expect(page.find('table tbody tr:nth-child(1) td:nth-child(4)')).to have_link 'Take'

    # Second quiz
    expect(page.find('table tbody tr:nth-child(2) td:nth-child(1)').text).to eq '2'
    expect(page.find('table tbody tr:nth-child(2) td:nth-child(2)').text).to eq quiz_2.title
    expect(page.find('table tbody tr:nth-child(2) td:nth-child(3)').text).to eq '0 times'
    expect(page.find('table tbody tr:nth-child(2) td:nth-child(4)')).to have_link 'Take'
  end

  # Scenario: Show the times that I took each quiz
  #   Given I am signed in
  #   When I visit the index page of the exams
  #   Then I see the times that I took each quiz
  scenario 'user sees the list of quizzes' do
    user = FactoryGirl.create(:user, :admin)
    quiz_1 = FactoryGirl.create(:quiz, title: 'Quiz 1')
    quiz_2 = FactoryGirl.create(:quiz, title: 'Quiz 2')
    quiz_3 = FactoryGirl.create(:quiz, title: 'Quiz 3')

    taken_quiz_1 = TakenQuiz.new(quiz: quiz_1)
    taken_quiz_1.answers << Answer.new(question: quiz_1.questions.first, choice: quiz_1.questions.first.choices.first)
    taken_quiz_1.answers << Answer.new(question: quiz_1.questions.second, choice: quiz_1.questions.second.choices.first)
    taken_quiz_1.answers << Answer.new(question: quiz_1.questions.third, choice: quiz_1.questions.third.choices.first)

    user.taken_quizzes << taken_quiz_1
    user.taken_quizzes << TakenQuiz.new(quiz: quiz_1)
    user.taken_quizzes << TakenQuiz.new(quiz: quiz_2)
    user.save!

    login_as(user, scope: :user)
    visit quizzes_path
    expect(page).to have_content 'Quizzes'

    # First quiz
    expect(page.find('table tbody tr:nth-child(1) td:nth-child(3)').text).to eq '2 times'

    # Second quiz
    expect(page.find('table tbody tr:nth-child(2) td:nth-child(3)').text).to eq '1 times'

    # Third quiz
    expect(page.find('table tbody tr:nth-child(3) td:nth-child(3)').text).to eq '0 times'
  end
end
