require File.dirname(__FILE__) + '/../spec_helper'
 
describe GoalsController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Goal.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Goal.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Goal.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(goal_url(assigns[:goal]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Goal.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    Goal.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Goal.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Goal.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Goal.first
    response.should redirect_to(goal_url(assigns[:goal]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    goal = Goal.first
    delete :destroy, :id => goal
    response.should redirect_to(goals_url)
    Goal.exists?(goal.id).should be_false
  end
end
