ActionController::Routing::Routes.draw do |map|
  map.devise_for :users

  map.resources :goals
  map.resources :experiences
  map.resources :users do |user|
    user.resources :experiences
    user.resources :goals
  end
  map.resources :goals do |goal|
    goal.resources :experiences
  end

  map.resources :votes
  map.resources :comments
  map.resources :taggings


  map.root :controller => 'home'
end
