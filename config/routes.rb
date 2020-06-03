Rails.application.routes.draw do
  get '/microposts', to: 'micropost_iframes#index'
  post '/follow', to: 'follow#create'
  root 'top_pages#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
