Given /^I have experiences content about (.+)$/ do |contents|
  # express the regexp above with the code you wish you had
  contents.split(', ').each do |content|
    Experience.create!(:content => content, :user_id => 1)
  end
end

Given /^I have no experiences$/ do
  Experience.delete_all
end

Then /^I should have ([0-9]+) experiences?$/ do |count|
  Experience.count.should == count.to_i
end

