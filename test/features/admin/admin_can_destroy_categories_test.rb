require 'test_helper'

class CategoryDestroyTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    @admin = User.create(first_name: 'Tom',
            last_name: 'Leskin',
            email: 'tleskin@msn.com',
            password: 'password',
            role: 1)
  end

  test 'admin can delete a category when logged in' do
    ApplicationController.any_instance.stubs(:current_user).returns(@admin)

    visit new_admin_category_path
    fill_in 'Label', with: 'tomorrow'
    click_link_or_button 'Create category'

    assert (page).has_content?('tomorrow')

    click_link_or_button 'Delete'

    refute (page).has_content?('tomorrow')
  end
end
