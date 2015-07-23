module RedMineTools

  def register_account
    go_to_home_page

    login = rand(9999).to_s + 'login'

    @browser.find_element(:class, 'register').click
    @browser.find_element(:id, 'user_login').send_keys login
    @browser.find_element(:id, 'user_password').send_keys 'ererere'
    @browser.find_element(:id, 'user_password_confirmation').send_keys 'ererere'
    @browser.find_element(:id, 'user_firstname').send_keys 'user'
    @browser.find_element(:id, 'user_lastname').send_keys login
    @browser.find_element(:id, 'user_mail').send_keys login + '@email.com'

    click_commit_button
    login
  end

  def login_to_account (login)
    @browser.find_element(:class, 'login').click
    @browser.find_element(:id, 'username').send_keys login
    @browser.find_element(:id, 'password').send_keys 'ererere'
    @browser.find_element(:name, 'login').click
    login
  end

  def logout_from_account
    @browser.find_element(:class, 'logout').click
  end

  def change_account_password
    @browser.find_element(:class, 'my-account').click
    @browser.find_element(:css, '.contextual .icon-passwd').click # does not locate if changed to :class, 'icon-passwd'
    @browser.find_element(:id, 'password').send_keys 'ererere'

    @browser.find_element(:id, 'new_password').send_keys 'ererere1'
    @browser.find_element(:id, 'new_password_confirmation').send_keys 'ererere1'
    click_commit_button
  end

  def create_new_project
    new_project_id = rand(9999).to_s + 'prj'
    new_project_name = new_project_id + 'name'

    @browser.find_element(:class, 'projects').click
    @browser.find_element(:css, '.contextual .icon-add').click

    @browser.find_element(:id, 'project_name').send_key new_project_name
    @browser.find_element(:id, 'project_identifier').send_key new_project_id
    click_commit_button

    new_project_id
  end

  def add_user_to_project(user_to_add)
    @browser.find_element(:id, 'tab-members').click
    @browser.find_element(:css, '#tab-content-members .icon-add').click

    wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
    wait.until { @browser.find_element(:id => 'principal_search').displayed? }

    @browser.find_element(:id, 'principal_search').send_key user_to_add

    wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
    wait.until { @browser.find_elements(:name => "membership[user_ids][]").count == 1 }


    @browser.find_element(:name, "membership[user_ids][]").click
    #what if there are multiple search results?

    @browser.find_element(:name, 'membership[role_ids][]').click
    click_commit_button
  end


  #select_role(role_name)

  def edit_user_roles

  end

  def create_project_version

  end

  def create_three_types_of_issues

  end

  def assert_issues_visible

  end

  def go_to_home_page
    @browser.get 'http://demo.redmine.org'
  end

  def click_commit_button
    @browser.find_element(:name, 'commit').click
  end





end