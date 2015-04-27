require 'test_helper'

class IdeaCreationTest < ActionDispatch::IntegrationTest
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
                role: 0)
  end

  test "User can see an idea" do

    user.ideas.create(title: 'Awesomeness', description: 'Everywhere')
    visit login_path
    fill_in 'Email', with: 'mike@dude.com'
    fill_in 'Password', with: 'password'
    click_link_or_button 'Login'

    assert (page).has_content?('Awesomeness')
  end

  test "User can create an idea with valid attributes" do

    visit login_path
    fill_in 'Email', with: 'mike@dude.com'
    fill_in 'Password', with: 'password'
    click_link_or_button 'Login'

    click_link_or_button 'Create New Idea'
    fill_in 'Title', with: 'Awesomeness'
    fill_in 'Description', with: 'Everywhere'
    click_link_or_button 'Submit'
    assert (page).has_content?('Awesomeness')
    assert (page).has_content?('Everywhere')
  end

  test 'user cannot create an idea without title' do
    User.create(first_name: 'Mike',
                last_name: 'Marco',
                email: 'mike@marco.com',
                password: 'password',
                password_confirmation: 'password',
                role: 0)

    visit login_path
    fill_in 'Email', with: 'mike@marco.com'
    fill_in 'Password', with: 'password'
    click_link_or_button 'Login'

    click_link_or_button 'Create New Idea'
    fill_in 'Description', with: 'Everywhere'
    click_link_or_button 'Submit'
    assert (page).has_content?("Title can't be blank")
    refute (page).has_content?('Everywhere')
  end

  test 'User cannot see other users ideas' do
    user.ideas.create(title: 'Awesomeness', description: 'Everywhere')
    user2.ideas.create(title: 'Build a half pipe', description: 'to skate')

    visit login_path
    fill_in 'Email', with: 'mike@dude.com'
    fill_in 'Password', with: 'password'
    click_link_or_button 'Login'

    refute (page).has_content?('Build a half pipe')
  end

end
