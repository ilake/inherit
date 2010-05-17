require 'spec_helper'

describe ExperiencesController do

  def mock_experience(stubs={})
    @mock_experience ||= mock_model(Experience, stubs)
  end

  describe "GET index" do
    it "assigns all experiences as @experiences" do
      Experience.stub(:find).with(:all).and_return([mock_experience])
      get :index
      assigns[:experiences].should == [mock_experience]
    end
  end

  describe "GET show" do
    it "assigns the requested experience as @experience" do
      Experience.stub(:find).with("37").and_return(mock_experience)
      get :show, :id => "37"
      assigns[:experience].should equal(mock_experience)
    end
  end

  describe "GET new" do
    it "assigns a new experience as @experience" do
      Experience.stub(:new).and_return(mock_experience)
      get :new
      assigns[:experience].should equal(mock_experience)
    end
  end

  describe "GET edit" do
    it "assigns the requested experience as @experience" do
      Experience.stub(:find).with("37").and_return(mock_experience)
      get :edit, :id => "37"
      assigns[:experience].should equal(mock_experience)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created experience as @experience" do
        Experience.stub(:new).with({'these' => 'params'}).and_return(mock_experience(:save => true))
        post :create, :experience => {:these => 'params'}
        assigns[:experience].should equal(mock_experience)
      end

      it "redirects to the created experience" do
        Experience.stub(:new).and_return(mock_experience(:save => true))
        post :create, :experience => {}
        response.should redirect_to(experience_url(mock_experience))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved experience as @experience" do
        Experience.stub(:new).with({'these' => 'params'}).and_return(mock_experience(:save => false))
        post :create, :experience => {:these => 'params'}
        assigns[:experience].should equal(mock_experience)
      end

      it "re-renders the 'new' template" do
        Experience.stub(:new).and_return(mock_experience(:save => false))
        post :create, :experience => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested experience" do
        Experience.should_receive(:find).with("37").and_return(mock_experience)
        mock_experience.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :experience => {:these => 'params'}
      end

      it "assigns the requested experience as @experience" do
        Experience.stub(:find).and_return(mock_experience(:update_attributes => true))
        put :update, :id => "1"
        assigns[:experience].should equal(mock_experience)
      end

      it "redirects to the experience" do
        Experience.stub(:find).and_return(mock_experience(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(experience_url(mock_experience))
      end
    end

    describe "with invalid params" do
      it "updates the requested experience" do
        Experience.should_receive(:find).with("37").and_return(mock_experience)
        mock_experience.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :experience => {:these => 'params'}
      end

      it "assigns the experience as @experience" do
        Experience.stub(:find).and_return(mock_experience(:update_attributes => false))
        put :update, :id => "1"
        assigns[:experience].should equal(mock_experience)
      end

      it "re-renders the 'edit' template" do
        Experience.stub(:find).and_return(mock_experience(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested experience" do
      Experience.should_receive(:find).with("37").and_return(mock_experience)
      mock_experience.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the experiences list" do
      Experience.stub(:find).and_return(mock_experience(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(experiences_url)
    end
  end

end
