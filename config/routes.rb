ActionController::Routing::Routes.draw do |map|

  map.resources :chats, :new => {:reply => :get}

  map.resources :question_experience_relations

  map.devise_for :users

  #因為我解不掉在controller 用link_to 做刪除動作的bug, 所以只好work around 
  map.destroy_experience "experiences/:id/destroy", :controller => 'experiences', :action => 'destroy'
  map.destroy_goal "categories/:id/destroy", :controller => 'goals', :action => 'destroy'
  map.resources :fans
  map.resources :questions
  map.resources :goals, :as => :categories
  map.resources :experiences
  map.resource :profile, :except => [:new, :create]

  map.search "search/:search", :controller =>'search', :action => 'index', :search => nil
  map.search_exps "search_exps/:search", :controller =>'search', :action => 'experiences', :search => nil
  map.search_goals "search_goals/:search", :controller =>'search', :action => 'goals', :search => nil
  map.search_questions "search_questions/:search", :controller =>'search', :action => 'questions', :search => nil

  map.user_exps "users/:user_id/:goal_id/experiences", :controller => 'experiences', :action => 'index'

  map.resources :users do |user|
    user.resource :profile, :except => [:new, :create]
    user.resources :experiences, :collection => { :select => :get }
    user.resources :goals, :as => :categories
    user.resources :fans, :collection => { :ifollow => :get }
  end
  map.resources :goals do |goal|
    goal.resources :experiences
  end

  map.resources :votes
  map.resources :comments
  map.resources :taggings

  map.home "home/:location", :controller => 'home', :action => 'user',  :location => nil
  

  map.root :controller => 'home'
end
