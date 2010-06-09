require File.dirname(__FILE__) + '/../spec_helper'
 
describe QuestionExperienceRelationsController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => QuestionExperienceRelation.first
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    QuestionExperienceRelation.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    QuestionExperienceRelation.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(question_experience_relation_url(assigns[:question_experience_relation]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => QuestionExperienceRelation.first
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    QuestionExperienceRelation.any_instance.stubs(:valid?).returns(false)
    put :update, :id => QuestionExperienceRelation.first
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    QuestionExperienceRelation.any_instance.stubs(:valid?).returns(true)
    put :update, :id => QuestionExperienceRelation.first
    response.should redirect_to(question_experience_relation_url(assigns[:question_experience_relation]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    question_experience_relation = QuestionExperienceRelation.first
    delete :destroy, :id => question_experience_relation
    response.should redirect_to(question_experience_relations_url)
    QuestionExperienceRelation.exists?(question_experience_relation.id).should be_false
  end
end
