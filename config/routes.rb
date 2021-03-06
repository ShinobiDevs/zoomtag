Zoomtag::Application.routes.draw do
  
  devise_for(:players,:controllers => { :sessions => "sessions" })

  resources :friends, only: [:index]

  resources :pictures, only: [:index]

  resources :challanges_actions

  resources :games do
    resources :challanges
    resources :answers
  end

  root to: "home#index"
end
