include Warden::Test::Helpers
Warden.test_mode!

# Feature: Continue quiz
#   As a user
#   I want to continue a quiz
RSpec.feature 'Conduct quiz', :devise do
  after(:each) do
    Warden.test_reset!
  end

  let(:user){ FactoryGirl.create(:user, :admin) }
  let(:quiz){ FactoryGirl.create(:quiz, title: 'Quiz 1') }

  before do
    # Let's ensure that our test data are correct.
    expect(quiz.questions.count).to eq 3

    quiz.questions.each do |question|
      expect(question.choices.count).to eq 4
    end
  end

  # Scenario: The user sees the continue button
  #   Given I am signed in
  #   When I visit the quizzes index page
  #   And I take a quiz
  #   And I submit the answer
  #   And I leave the quiz page
  #   And I visit the quizzes index page
  #   Then I should see the continue button
  scenario 'user sees the continue button', js: true do
    quiz_2 = FactoryGirl.create(:quiz, title: 'Quiz 2')

    login_as(user, scope: :user)
    visit quizzes_path
    click_link_or_button "take-quiz-#{quiz.id}"
    choose(quiz.questions.first.choices.first.statement)

    click_link_or_button 'Next'

    visit quizzes_path
    expect(page.find("#take-quiz-#{quiz.id}").text).to eq 'Continue'
    expect(page.find("#take-quiz-#{quiz_2.id}").text).to eq 'Take'
  end

  # Scenario: The next answer is displayed
  #   Given I am signed in
  #   When I visit the quizzes index page
  #   And I take a quiz
  #   And I submit the answer
  #   And I leave the quiz page
  #   And I revisit the quiz page
  #   Then I should see the next answer
  scenario 'user sees the next question', js: true do
    login_as(user, scope: :user)
    visit quizzes_path
    click_link_or_button "take-quiz-#{quiz.id}"
    choose(quiz.questions.first.choices.first.statement)

    click_link_or_button 'Next'

    visit quizzes_path
    click_link_or_button "take-quiz-#{quiz.id}"

    expect(page).to have_content quiz.title
    expect(page).to have_content "#{quiz.questions.second.prompt} (2/#{quiz.questions.count})"

    first_choice = quiz.questions.second.choices.first
    expect(page.find("#choice-#{first_choice.id}")).to have_content first_choice.statement
    expect(page.find("#choice-#{first_choice.id}")).to have_field "choice-#{first_choice.id}-radio"

    second_choice = quiz.questions.second.choices.second
    expect(page.find("#choice-#{second_choice.id}")).to have_content second_choice.statement
    expect(page.find("#choice-#{second_choice.id}")).to have_field "choice-#{second_choice.id}-radio"

    third_choice = quiz.questions.second.choices.third
    expect(page.find("#choice-#{third_choice.id}")).to have_content third_choice.statement
    expect(page.find("#choice-#{third_choice.id}")).to have_field "choice-#{third_choice.id}-radio"

    fourth_choice = quiz.questions.second.choices.fourth
    expect(page.find("#choice-#{fourth_choice.id}")).to have_content fourth_choice.statement
    expect(page.find("#choice-#{fourth_choice.id}")).to have_field "choice-#{fourth_choice.id}-radio"
  end

  # Scenario: Finish a paused quiz
  #   Given I am signed in
  #   When I visit the quizzes index page
  #   And I take a quiz
  #   And I submit the answer
  #   And I leave the quiz page
  #   And I revisit the quiz page
  #   Then I can finish the quiz
  scenario 'user finishes the paused quiz', js: true do
    login_as(user, scope: :user)
    visit quizzes_path
    click_link_or_button "take-quiz-#{quiz.id}"
    choose(quiz.questions.first.choices.first.statement)

    click_link_or_button 'Next'

    visit quizzes_path
    click_link_or_button "take-quiz-#{quiz.id}"

    choose(quiz.questions.second.choices.first.statement)
    click_link_or_button 'Next'

    choose(quiz.questions.third.choices.first.statement)
    click_link_or_button 'Finish'

    sleep 0.5

    expect(current_path).to eq root_path
    expect(page).to have_content 'Thank you!'
  end
end
