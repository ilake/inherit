require 'spec_helper'

describe "/experiences/new.html.erb" do
  include ExperiencesHelper

  before(:each) do
    assigns[:experience] = stub_model(Experience,
      :new_record? => true,
      :content => "value for content"
    )
  end

  it "renders new experience form" do
    render

    response.should have_tag("form[action=?][method=post]", experiences_path) do
      with_tag("textarea#experience_content[name=?]", "experience[content]")
    end
  end
end
