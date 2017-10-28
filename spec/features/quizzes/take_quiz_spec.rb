include Warden::Test::Helpers
Warden.test_mode!

# Feature: Take quiz
#   As a user
#   I want to take a quiz
RSpec.feature 'Take quiz', :devise do
  after(:each) do
    Warden.test_reset!
  end

  # Scenario: Take quiz
  #   Given I am signed in
  #   When I visit the quizzes index page
  #   And I click the take button
  #   Then The quiz should be taken
  scenario 'I take a quiz' do
    user = FactoryGirl.create(:user, :admin)
    quiz_1 = FactoryGirl.create(:quiz, title: 'Quiz 1')
    quiz_2 = FactoryGirl.create(:quiz, title: 'Quiz 2')

    login_as(user, scope: :user)
    visit quizzes_path

    expect do
      click_link_or_button "take-quiz-#{quiz_1.id}"
    end.to change{ TakenQuiz.count }.by 1

    last_taken_quiz = TakenQuiz.last
    expect(last_taken_quiz.quiz).to eq quiz_1
    expect(current_path).to eq "/quizzes/#{quiz_1.id}"
  end

  # Scenario: Failed to take a quiz
  #   Given I am signed in
  #   When I visit the quizzes index page
  #   And I click the take button
  #   And An error occurred
  #   Then I should see the error message
  scenario 'I take a quiz' do
    user = FactoryGirl.create(:user, :admin)
    quiz_1 = FactoryGirl.create(:quiz, title: 'Quiz 1')
    quiz_2 = FactoryGirl.create(:quiz, title: 'Quiz 2')
    expect_any_instance_of(TakenQuiz).to receive(:save).and_return false

    login_as(user, scope: :user)
    visit quizzes_path

    expect do
      click_link_or_button "take-quiz-#{quiz_1.id}"
    end.not_to change{ TakenQuiz.count }

    expect(page).to have_content 'Something went wrong, please try again'
    expect(current_path).to eq "/quizzes"
  end
end
