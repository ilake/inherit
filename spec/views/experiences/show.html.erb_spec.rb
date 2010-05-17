require 'spec_helper'

describe "/experiences/show.html.erb" do
  include ExperiencesHelper
  before(:each) do
    assigns[:experience] = @experience = stub_model(Experience,
      :content => "value for content"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ content/)
  end
end
