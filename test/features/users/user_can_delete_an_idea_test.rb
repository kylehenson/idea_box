require 'test_helper'

class IdeaDeleteTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    @user = User.create(first_name: 'Mike',
                last_name: 'Dude',
                email: 'mike@dude.com',
                password: 'password',
                password_confirmation: 'password',
                role: 0)
  end

  test 'user can delete an idea' do
    visit login_path
    fill_in 'Email', with: 'mike@dude.com'
    fill_in 'Password', with: 'password'
    click_link_or_button 'Login'

    visit new_idea_path
    fill_in 'Title', with: 'Sky dive'
    fill_in 'Description', with: 'Tomorrow'
    click_link_or_button 'Submit'
    assert page.has_content?('Sky dive')

    click_link_or_button 'Delete'

    refute page.has_content?('Sky dive')
  end
end
