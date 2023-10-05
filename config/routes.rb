Rails.application.routes.draw do
  root 'users#index'

  resources :users do 
    post 'organization',to: "organizations#create", as: "organizations"
  end

  get 'find', to: "users#find_user", as: "find_user"

  resources :organizations do 
    post 'management',to: "managements#create", as: "managements"
  end

  resources :managements do 
    post 'activity',to: "activities#create", as: "activities"
  end
  patch 'complete/:id',to: "activities#complete", as: "activity_complete"
end
