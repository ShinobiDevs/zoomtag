Zoomtag::Application.routes.draw do
  devise_for(:players,:controllers => { :sessions => "sessions" })

  resources :games
end
