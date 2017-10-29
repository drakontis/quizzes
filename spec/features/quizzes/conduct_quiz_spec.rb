include Warden::Test::Helpers
Warden.test_mode!

# Feature: Conduct quiz
#   As a user
#   I want to conduct a quiz
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

  # Scenario: Show the first question
  #   Given I am signed in
  #   When I visit the quizzes index page
  #   And I take a quiz
  #   Then I should see the first question
  scenario 'user sees the first question' do
    login_as(user, scope: :user)
    visit quizzes_path

    click_link_or_button "take-quiz-#{quiz.id}"

    expect(page).to have_content quiz.title
    expect(page).to have_content "#{quiz.questions.first.prompt} (1/#{quiz.questions.count})"

    first_choice = quiz.questions.first.choices.first
    expect(page.find("#choice-#{first_choice.id}")).to have_content first_choice.statement
    expect(page.find("#choice-#{first_choice.id}")).to have_field "choice-#{first_choice.id}-radio"

    second_choice = quiz.questions.first.choices.second
    expect(page.find("#choice-#{second_choice.id}")).to have_content second_choice.statement
    expect(page.find("#choice-#{second_choice.id}")).to have_field "choice-#{second_choice.id}-radio"

    third_choice = quiz.questions.first.choices.third
    expect(page.find("#choice-#{third_choice.id}")).to have_content third_choice.statement
    expect(page.find("#choice-#{third_choice.id}")).to have_field "choice-#{third_choice.id}-radio"

    fourth_choice = quiz.questions.first.choices.fourth
    expect(page.find("#choice-#{fourth_choice.id}")).to have_content fourth_choice.statement
    expect(page.find("#choice-#{fourth_choice.id}")).to have_field "choice-#{fourth_choice.id}-radio"
  end

  # Scenario: The submit button should be disabled
  #   Given I am signed in
  #   When I visit the quizzes index page
  #   And I take a quiz
  #   Then The submit button should be disabled
  scenario 'user sees the first question' do
    login_as(user, scope: :user)
    visit quizzes_path
    click_link_or_button "take-quiz-#{quiz.id}"

    expect(page).to have_button('Next', disabled: true)
  end

  # Scenario: The submit button is being enabled when I choose an answer
  #   Given I am signed in
  #   When I visit the quizzes index page
  #   And I take a quiz
  #   And I choose an answer
  #   Then The submit button should be enabled
  scenario 'user sees the first question', js: true do
    login_as(user, scope: :user)
    visit quizzes_path
    click_link_or_button "take-quiz-#{quiz.id}"
    choose(quiz.questions.first.choices.first.statement)

    expect(page).to have_button('Next', disabled: false)
  end

  # Scenario: The next answer is displayed
  #   Given I am signed in
  #   When I visit the quizzes index page
  #   And I take a quiz
  #   And I submit the answer
  #   Then I should see the next answer
  scenario 'user sees the next question', js: true do
    login_as(user, scope: :user)
    visit quizzes_path
    click_link_or_button "take-quiz-#{quiz.id}"
    choose(quiz.questions.first.choices.first.statement)

    taken_quiz = TakenQuiz.last

    expect do
      expect do
        click_link_or_button 'Next'
        sleep 0.5
      end.to change{ Answer.count }.by 1
    end.to change{ taken_quiz.reload.answers.count }.by 1

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

  # Scenario: Error when submitting the answer
  #   Given I am signed in
  #   When I visit the quizzes index page
  #   And I take a quiz
  #   And I choose an answer
  #   And An error has been occurred
  #   Then I am redirected to root path
  scenario 'user is redirected to root path if error occurred', js: true do
    login_as(user, scope: :user)
    visit quizzes_path
    click_link_or_button "take-quiz-#{quiz.id}"
    choose(quiz.questions.first.choices.first.statement)

    allow_any_instance_of(TakenQuiz).to receive_message_chain(:answers, :<<).and_return false

    click_link_or_button 'Next'
    sleep 0.5

    expect(current_path).to eq root_path
    expect(page).to have_content 'Something went wrong, please try again later'
  end

  # Scenario: Last question of the quiz
  #   Given I am signed in
  #   When I visit the quizzes index page
  #   And I take a quiz
  #   And I am in the last question
  #   Then I should see the finish button
  scenario 'I am in the last question', js: true do
    login_as(user, scope: :user)
    visit quizzes_path
    click_link_or_button "take-quiz-#{quiz.id}"

    choose(quiz.questions.first.choices.first.statement)
    click_link_or_button 'Next'

    choose(quiz.questions.second.choices.first.statement)
    click_link_or_button 'Next'

    expect(page).to have_button('Finish', disabled: true)
  end

  # Scenario: Submit the last question of the quiz
  #   Given I am signed in
  #   When I visit the quizzes index page
  #   And I take a quiz
  #   And I am in the last question
  #   And I submit the last question
  #   Then I am redirected to root_path
  scenario 'I submit the last question', js: true do
    login_as(user, scope: :user)
    visit quizzes_path
    click_link_or_button "take-quiz-#{quiz.id}"

    choose(quiz.questions.first.choices.first.statement)
    click_link_or_button 'Next'

    choose(quiz.questions.second.choices.first.statement)
    click_link_or_button 'Next'

    choose(quiz.questions.third.choices.first.statement)
    click_link_or_button 'Finish'

    sleep 0.5

    expect(current_path).to eq quizzes_path
    expect(page).to have_content 'Thank you!'
  end
end
