require 'spec_helper'

describe "/experiences/edit.html.erb" do
  include ExperiencesHelper

  before(:each) do
    assigns[:experience] = @experience = stub_model(Experience,
      :new_record? => false,
      :content => "value for content"
    )
  end

  it "renders the edit experience form" do
    render

    response.should have_tag("form[action=#{experience_path(@experience)}][method=post]") do
      with_tag('textarea#experience_content[name=?]', "experience[content]")
    end
  end
end
