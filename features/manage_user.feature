Feature: Verify User
    In order to verify user
    As an user
    I want to trace many situation

    Scenario Outline: Confirmed User And Guest see Function or not
      Given the following user records
        | email          | username | password |
        | lake@gmail.com | lake     | secret   | 
        #    |                |          | secret   |
      Given "<login>" is "<confirm>"
      Given I am logged in as "<login>" with password "secret"
      When I am on the list of "<owner>" experiences
      Then I should <action>
      
      Examples:
        | login          | owner | confirm   | action               |
        | lake@gmail.com | lake  | confirmed | see "New experience" |
        | lake@gmail.com | lake  | unconfirm | not see "New experience" |
        #|                 | lake  | not see "New Experience" |
