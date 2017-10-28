include Warden::Test::Helpers
Warden.test_mode!

# Feature: Navigation links
#   As a visitor
#   I want to see navigation links
#   So I can find home, sign in, or sign up
RSpec.feature 'Navigation links', :devise do

  # Scenario: View navigation links
  #   Given I am logged in
  #   When I visit the home page
  #   Then I see "Quizzes", "Home"
  scenario 'view navigation links' do
    user = FactoryGirl.create(:user, :admin)
    login_as(user, scope: :user)
    visit root_path
    expect(page).to have_link 'Quizzes'
    expect(page).to have_link 'Home'
  end

end
