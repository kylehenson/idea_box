require 'test_helper'

class CategoryCreationTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    @admin = User.create(first_name: 'Tom',
            last_name: 'Leskin',
            email: 'tleskin@msn.com',
            password: 'password',
            role: 1)
    @default_user = User.create(first_name: 'Liz',
            last_name: 'Smith',
            email: 'lsmith@msn.com',
            password: 'password',
            role: 0)
  end

  test 'displays categories with admin logged in' do
    ApplicationController.any_instance.stubs(:current_user).returns(@admin)

      visit admin_categories_path

      assert (page).has_content?('Existing Categories')
  end

  test 'displays a 404 with default user logged in' do
    ApplicationController.any_instance.stubs(:current_user).returns(@default_user)

    visit admin_categories_path

    assert (page).has_content?("The page you were looking for doesn't exist (404)")
  end

  test 'a category can be created with admin logged in' do
    ApplicationController.any_instance.stubs(:current_user).returns(@admin)

    visit new_admin_category_path
    fill_in 'Label', with: 'brilliant'
    click_link_or_button 'Create category'

    assert (page).has_content?('Existing Categories:')
    assert (page).has_content?('brilliant')
  end
end
