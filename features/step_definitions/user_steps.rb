Given /^the following (.+) records?$/ do |factory, table|
  table.hashes.each do |hash|
    Factory(factory, hash)
  end
end

Given /^I am logged in as "([^\"]*)" with password "([^\"]*)"$/ do |email, password|
  unless email.blank? #filter guest
    visit new_user_session_url
    fill_in "user_email", :with => email
    fill_in "user_password", :with => password
    click_button "user_submit"
  end
end

Given /^"([^\"]*)" is "([^\"]*)"$/ do |email, confirm_or_not|
  if u = User.find_by_email(email)
    case confirm_or_not
    when 'confirmed'
      u.confirmed_at = Time.now
      u.save!
    end
  end
end
