require 'spec_helper'

describe "/experiences/index.html.erb" do
  include ExperiencesHelper

  before(:each) do
    assigns[:experiences] = [
      stub_model(Experience,
        :content => "value for content"
      ),
      stub_model(Experience,
        :content => "value for content"
      )
    ]
  end

  it "renders a list of experiences" do
    render
    response.should have_tag("tr>td", "value for content".to_s, 2)
  end
end
