ActionController::Routing::Routes.draw do |map|
  map.devise_for :users

  map.home "home/:location", :controller => 'home', :action => 'user',  :location => nil
  map.search "search/:search", :controller =>'search', :action => 'index', :search => nil
  map.search_exps "search_exps/:search", :controller =>'search', :action => 'experiences', :search => nil
  map.search_goals "search_goals/:search", :controller =>'search', :action => 'goals', :search => nil
  map.search_questions "search_questions/:search", :controller =>'search', :action => 'questions', :search => nil
  map.search_rands "excite", :controller =>'search', :action => 'random'
  map.user_home "users/:username", :controller => 'experiences', :action => 'index'
  map.user_exps "users/:user_id/:goal_id/experiences", :controller => 'experiences', :action => 'index'
  map.tag  "taggings/:taggable_type/:id", :controller => 'taggings', :action => 'show'
  map.que_loc ":location/questions", :controller => 'questions', :action => 'index'
  map.chat_loc ":location/chats", :controller => 'chats', :action => 'index'

  #因為我解不掉在controller 用link_to 做刪除動作的bug, 所以只好work around 
  map.destroy_experience "experiences/:id/destroy", :controller => 'experiences', :action => 'destroy'
  map.destroy_goal "categories/:id/destroy", :controller => 'goals', :action => 'destroy'

  map.resources :fans, :except => [:new, :show, :edit, :update]
  map.resources :questions
  map.resources :goals, :as => :categories, :except => [:index] do |goal|
    goal.resources :experiences, :only => [:new]
  end

  map.resources :experiences, :except => [:index]
  #map.resource :profile, :only => [:show, :edit, :update]

  map.resources :users do |user|
    user.resource :profile, :only => [:show, :edit, :update]
    user.resources :experiences, :collection => { :select => :get }, :except => [:index]
    user.resources :goals, :as => :categories, :except => [:index]
    user.resources :fans, :collection => { :ifollow => :get }, :except => [:show, :edit, :update]
    user.resources :questions, :only => [:index]
    user.resources :chats, :only => [:index, :create, :show]
  end
  
  map.user_location "user_location", :controller => 'home', :action => 'user_location'
  map.change_location "change_user_location", :controller => 'home', :action => 'change_user_location'
  map.resources :chats, :new => {:reply => :get}, :except => [:show, :new]
  map.resources :question_experience_relations, :only => [:create]

  map.resources :votes, :only => [:create]
  map.resources :comments, :except => [:index, :show, :edit, :update]
  

  map.root :controller => 'home'
end

#map.resources :taggings
