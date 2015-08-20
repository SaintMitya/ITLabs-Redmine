Feature: Register Feature

Scenario: As a user I want to register an account
  Given I am on start page
  When I click Register link
  And I register account for DRTestLogin user
  Then account is registered

Scenario: As a user I want to login and logout
  Given I am on start page
  When I login as DRTestLogin with ererere password
  Then I am logged in
  When I logout
  Then I am logged out

Scenario: As a user I want to change password
  Given I am on start page
  When I login as DRTestLogin with ererere password
  And I change password
  Then the password is changed

Scenario: As a user I want to create a new project
  Given I am on start page
  When I login as DRTestLogin with ererere password
  And I create new project
  Then the new project is created

# this one fails on verification - unexpected values in array: "DRTtLogin2" instead of "DRTestLogin2"
Scenario: As a user I want to add user to project
  Given I am on start page
#  When I register account for DRTestLogin2 user
#  And I logout
  When I login as DRTestLogin with ererere password
  And I create new project
  And I add user DRTestLogin2 user to the project
  Then DRTestLogin2 user is added to the project

Scenario: As a user I want to edit user roles
  Given I am on start page
#  When I register account for DRTestLogin2 user
#  And I logout
  And I login as DRTestLogin with ererere password
  And I create new project
  And I add user DRTestLogin2 user to the project
  And I add Developer role to DRTestLogin2 user
#  Then user DRTestLogin2 has a Developer role