Rails.application.routes.draw do
  get '/microposts', to: 'micropost_iframes#index'
  root 'top_pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
