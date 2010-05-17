Feature: Manage Experience
    In order to make a experience
    As an author
    I want to create and manage experiences

    Scenario: Experience Show
        Given a user exists with username: "lake", email: "lake@gmail.com", password: "secret"
        Given a experience exists with content: "web developer", user_id: "1"
        When I go to the "that user" show page for that experience
        Then I should see "web developer" within "h1"

    Scenario: Experiences List
        Given a user exists with username: "lake", email: "lake@gmail.com", password: "secret"
        Given the following experiences exist
            | content | user_id |
            | ruby    | 1       |
            | rails   | 1       |
        When I go to path "/users/1/experiences"
        Then I should see "ruby"
        And I should see "rails"
        #Then show me the page


    Scenario: Experiences List2
        Given a user exists with username: "lake", email: "lake@gmail.com", password: "secret"
        Given I have experiences content about web developer, wakeup early
        When I go to the list of "lake" experiences
        Then I should see "web developer"
        And I should see "wakeup early"
