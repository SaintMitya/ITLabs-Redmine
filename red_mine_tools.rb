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

    initially_set_user_roles("Manager")

    click_add_member_button
  end

  def initially_set_user_roles(user_role) # to be changed to array
    elements_array = @browser.find_elements(:css, '.roles-selection>label')
    elements_array.map!(&:text) # or elements_array.map!{|i| i.text}
    index = elements_array.index(user_role)
    @browser.find_elements(:css, '.roles-selection>label')[index].click
  end

  def edit_user_roles(user, role)
    case role
      when "Manager"
        role_value = '3'
      when "Developer"
        role_value = '4'
      when "Reporter"
        role_value = '5'
      else
        puts role + " is an invalid user role"
    end

    wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
    wait.until { @browser.find_elements(:css, '.list.members .user.active').count > 1 }

    @browser.find_element(:xpath, ".//*[contains(text(),'#{user}')]/../..//*[@class='icon icon-edit']").click
    @browser.find_element(:xpath, ".//*[contains(text(),'#{user}')]/../..//input[@name='membership[role_ids][]'][@type='checkbox'][@value='#{role_value}']").click
    @browser.find_element(:xpath, ".//*[contains(text(),'#{user}')]/../..//input[@type='submit'][@value='Save']").click
  end

  def verify_user_added_to_project(user_to_add)
    wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
    wait.until { @browser.find_elements(:css, '.list.members .user.active').count > 1 }
    users_array = get_active_project_members
    # puts (users_array.include? user_to_add)
    # puts user_to_add + " - added user"
    # users_array.each{|x| puts x}
    assert_true(users_array.include? user_to_add)
  end

  def get_active_project_members
    users_array = @browser.find_elements(:css, '.list.members .user.active')
    users_array.map!(&:text)
    #users_array.each{|el| puts el}
    users_array.map!{|el| el.delete "user "}
    #users_array.each{|x| puts x}
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

  def click_add_member_button
    @browser.find_element(:id, "member-add-submit").click
  end





end