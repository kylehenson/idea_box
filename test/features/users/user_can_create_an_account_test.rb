require 'test_helper'

class UserCreateAccountTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  test 'user can create an account' do
    visit new_user_path
    fill_in 'First name', with: 'Steph'
    fill_in 'Last name', with: 'Stafford'
    fill_in 'Email', with: 'steph@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_link_or_button 'Create account'

    assert (page).has_content?('Welcome Steph')
  end

  test 'user cannot create an account without a first name' do
    visit new_user_path
    fill_in 'Last name', with: 'Stafford'
    fill_in 'Email', with: 'steph@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_link_or_button 'Create account'

    refute (page).has_content?('Welcome Steph')
    assert (page).has_content?("First name can't be blank")
  end

  test 'user cannot create an account with a duplicate email' do
    visit new_user_path
    fill_in 'First name', with: 'Steph'
    fill_in 'Last name', with: 'Stafford'
    fill_in 'Email', with: 'steph@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_link_or_button 'Create account'

    assert_equal 1, User.count
    assert (page).has_content?("Welcome Steph")

    visit new_user_path
    fill_in 'First name', with: 'Steph'
    fill_in 'Last name', with: 'Stafford'
    fill_in 'Email', with: 'steph@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_link_or_button 'Create account'

    assert_equal 1, User.count
    refute (page).has_content?("Welcome Steph")
  end
end
