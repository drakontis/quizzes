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
    3.times do |question_index|
      question = FactoryGirl.build(:question, prompt: "Question #{question_index+1}", quiz: quiz)

      4.times do |choice_index|
        question.choices << FactoryGirl.build(:choice, statement: "choice #{question_index+1}-#{choice_index+1}")
      end
      question.save!
    end

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

  # Scenario:The submit button should be disabled
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

  # Scenario:The submit button is being enabled when I choose an answer
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

end
