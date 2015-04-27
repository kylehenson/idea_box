require 'test_helper'

class IdeaUpdateTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  attr_reader :user, :user2

  def setup
    @user = User.create(first_name: 'Mike',
                last_name: 'Dude',
                email: 'mike@dude.com',
                password: 'password',
                password_confirmation: 'password',
                role: 0)
    @user2 = User.create(first_name: 'Angela',
                last_name: 'Staff',
                email: 'angela@staff.com',
                password: 'staff',
                password_confirmation: 'staff',
                role: 1)
  end

  test 'user can edit an idea' do
    visit login_path
    fill_in 'Email', with: 'mike@dude.com'
    fill_in 'Password', with: 'password'
    click_link_or_button 'Login'

    visit new_idea_path
    fill_in 'Title', with: 'Title'
    fill_in 'Description', with: 'Description'
    click_link_or_button 'Submit'

    assert (page).has_content?('Title')
    assert (page).has_content?('Description')

    click_link_or_button 'Edit'
    fill_in 'Title', with: 'New Title'
    fill_in 'Description', with: 'New Description'
    click_link_or_button 'Update idea'

    assert (page).has_content?('New Title')
    assert (page).has_content?('New Description')
  end

  test 'user can edit the title for an idea without a description' do
    visit login_path
    fill_in 'Email', with: 'mike@dude.com'
    fill_in 'Password', with: 'password'
    click_link_or_button 'Login'

    visit new_idea_path
    fill_in 'Title', with: 'Title'
    fill_in 'Description', with: 'Description'
    click_link_or_button 'Submit'

    assert (page).has_content?('Title')
    assert (page).has_content?('Description')

    click_link_or_button 'Edit'
    fill_in 'Title', with: 'New Title'
    click_link_or_button 'Update idea'

    assert (page).has_content?('New Title')
    refute (page).has_content?('New Description')
  end
end
