require 'spec_helper'

describe ExperiencesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/experiences" }.should route_to(:controller => "experiences", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/experiences/new" }.should route_to(:controller => "experiences", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/experiences/1" }.should route_to(:controller => "experiences", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/experiences/1/edit" }.should route_to(:controller => "experiences", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/experiences" }.should route_to(:controller => "experiences", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/experiences/1" }.should route_to(:controller => "experiences", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/experiences/1" }.should route_to(:controller => "experiences", :action => "destroy", :id => "1") 
    end
  end
end
