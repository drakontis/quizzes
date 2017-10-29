include Warden::Test::Helpers
Warden.test_mode!

# Feature: Authorization
#   As a user
#   I want to visit the active admin dashboard
RSpec.feature 'Authorization', :devise do

  # Scenario: Try to access dashboard as user
  #   Given I am logged in as user
  #   When I visit admin page
  #   Then I am redirected to root url
  scenario 'visit admin dashboard as user' do
    user = FactoryGirl.create(:user, :user)
    login_as(user, scope: :user)

    visit admin_root_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'You are not authorized to access this page!'
  end

  # Scenario: Try to access dashboard as vip
  #   Given I am logged in as user
  #   When I visit admin page
  #   Then I am redirected to root url
  scenario 'visit admin dashboard as vip' do
    user = FactoryGirl.create(:user, :vip)
    login_as(user, scope: :user)

    visit admin_root_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'You are not authorized to access this page!'
  end

  # Scenario: Try to access dashboard as admin
  #   Given I am logged in as user
  #   When I visit admin page
  #   Then I am redirected to admin dashboard
  scenario 'visit admin dashboard as admin' do
    user = FactoryGirl.create(:user, :admin)
    login_as(user, scope: :user)

    visit admin_root_path

    expect(current_path).to eq admin_root_path
  end
end
