Zoomtag::Application.routes.draw do
  
  get "home/index"

  devise_for(:players,:controllers => { :sessions => "sessions" })

  resources :friends, only: [:index]

  resources :games do
    resources :challanges
    resources :answers
  end

  root to: "home#index"
end
