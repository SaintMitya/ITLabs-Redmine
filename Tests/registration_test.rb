require 'selenium-webdriver'
require 'test/unit'
require_relative '../red_mine_tools'

class RegistrationTest < Test::Unit::TestCase

  include RedMineTools

  def setup
    @browser = Selenium::WebDriver.for :firefox
  end


###################_TESTS_###################

  def test_01_positive_registration
    go_to_home_page

    register_account
    assert_true(@browser.find_element(:id, 'flash_notice').displayed?)
  end

  def test_02_login_logout
    go_to_home_page

    login = register_account

    logout_from_account
    login_to_account(login)
    assert_true(@browser.find_element(:id, 'loggedas').displayed?)
    logout_from_account
    assert_true(@browser.find_element(:class, 'login').displayed?) # Making sure I'm not logged in (logout is successful)
  end

  def test_03_change_password
    go_to_home_page
    login = register_account
    change_account_password
    assert_true(@browser.find_element(:id, 'flash_notice').displayed?)
  end

  def test_04_create_new_project
    go_to_home_page
    register_account
    create_new_project
    assert_true(@browser.find_element(:id, 'flash_notice').displayed?)
  end

  # def test_05_add_user_to_project
  #   go_to_home_page
  #   user_to_add = register_account
  #   logout_from_account
  #   register_account
  #   create_new_project
  #   add_user_to_project(user_to_add)
  # end

  # def test_06_edit_user_roles
  #
  # end
  #
  # def test_07_create_project_version
  #
  # end
  #
  # def test_08_create_three_types_of_issues
  #
  # end
  #
  # def test_09_assert_issues_visible
  #
  # end

#################_METHODS_#################




  def teardown
    @browser.quit
  end

end