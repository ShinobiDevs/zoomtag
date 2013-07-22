Zoomtag::Application.routes.draw do
  
  get "home/index"
  devise_for(:players,:controllers => { :sessions => "sessions" })

  resources :games do
    resources :challanges
  end

  root to: "home#index"
end
