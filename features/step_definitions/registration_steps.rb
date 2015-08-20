Given(/^I am on start page$/) do
  @driver.navigate.to 'http://demo.redmine.org'
end

When(/^I click ([^"]*) link$/) do |link_name|
  @driver.find_element(link_text: link_name).click
end

And(/^I register account for ([^"]*) user$/) do |login|
  @driver.find_element(:class, 'register').click
  @driver.find_element(:id, 'user_login').send_keys login
  @driver.find_element(:id, 'user_password').send_keys 'ererere'
  @driver.find_element(:id, 'user_password_confirmation').send_keys 'ererere'
  @driver.find_element(:id, 'user_firstname').send_keys 'user'
  @driver.find_element(:id, 'user_lastname').send_keys login
  @driver.find_element(:id, 'user_mail').send_keys login + '@email.com'

  @driver.find_element(:name, 'commit').click
  login
end

Then(/^account is registered$/) do
  @driver.find_element(:id, 'flash_notice').displayed?.should == true
end

When(/^I login as ([^"]*) with ([^"]*) password$/) do |login, password|
  @driver.find_element(:class, 'login').click
  @driver.find_element(:id, 'username').send_keys login
  @driver.find_element(:id, 'password').send_keys password
  @driver.find_element(:name, 'login').click
end

Then(/^I am logged in$/) do
  @driver.find_element(:id, 'loggedas').displayed?.should == true
end

When(/^I logout$/) do
  @driver.find_element(:class, 'logout').click
end

Then(/^I am logged out$/) do
  @driver.find_element(:class, 'login').displayed?.should == true
end

And(/^I change password$/) do
  @driver.find_element(:class, 'my-account').click
  @driver.find_element(:css, '.contextual .icon-passwd').click
  @driver.find_element(:id, 'password').send_keys 'ererere'

  @driver.find_element(:id, 'new_password').send_keys 'ererere1'
  @driver.find_element(:id, 'new_password_confirmation').send_keys 'ererere1'

  @driver.find_element(:name, 'commit').click
end

Then(/^the password is changed$/) do
  @driver.find_element(:id, 'flash_notice').displayed?.should == true
end

And(/^I create new project$/) do
  new_project_id = rand(9999).to_s + 'prj'
  new_project_name = new_project_id + 'name'

  @driver.find_element(:class, 'projects').click
  @driver.find_element(:css, '.contextual .icon-add').click

  @driver.find_element(:id, 'project_name').send_key new_project_name
  @driver.find_element(:id, 'project_identifier').send_key new_project_id

  @driver.find_element(:name, 'commit').click
end

Then(/^the new project is created$/) do
  @driver.find_element(:id, 'flash_notice').displayed?.should == true
end

And(/^I add user ([^"]*) user to the project$/) do |user|
  @driver.find_element(:id, 'tab-members').click
  @driver.find_element(:css, '#tab-content-members .icon-add').click

  wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
  wait.until { @driver.find_element(:id => 'principal_search').displayed? }

  @driver.find_element(:id, 'principal_search').send_key user

  wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
  wait.until { @driver.find_elements(:name => "membership[user_ids][]").count == 1 }

  @driver.find_element(:name, "membership[user_ids][]").click

  elements_array = @driver.find_elements(:css, '.roles-selection>label')
  elements_array.map!(&:text)
  index = elements_array.index('Manager')
  @driver.find_elements(:css, '.roles-selection>label')[index].click

  @driver.find_element(:id, "member-add-submit").click
end

Then(/^([^"]*) user is added to the project$/) do |user|
  wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
  wait.until { @driver.find_elements(:css, '.list.members .user.active').count > 1 }
  # users_array = get_active_project_members
  users_array = @driver.find_elements(:css, '.list.members .user.active') # outputs array with "DRTtLogin" and "DRTtLogin2" - don't understand why
  users_array.map!(&:text)
  users_array.map!{|el| el.delete "user "}
  puts users_array.include?user
  users_array.include?user.should == true
end

And(/^I add ([^"]*) role to ([^"]*) user$/) do |role, user|
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
  wait.until { @driver.find_elements(:css, '.list.members .user.active').count > 1 }

  @driver.find_element(:xpath, ".//*[contains(text(),'#{user}')]/../..//*[@class='icon icon-edit']").click
  @driver.find_element(:xpath, ".//*[contains(text(),'#{user}')]/../..//input[@name='membership[role_ids][]'][@type='checkbox'][@value='#{role_value}']").click
  @driver.find_element(:xpath, ".//*[contains(text(),'#{user}')]/../..//input[@type='submit'][@value='Save']").click
end

Then(/^user ([^"]*) has a ([^"]*) role$/) do |user, role|
  pending
end