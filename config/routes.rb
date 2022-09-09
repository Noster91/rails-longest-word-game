Rails.application.routes.draw do
  # Defines the root path route ("/")
  get '/new', to: 'games#new'
  get '/score', to: 'games#score'
  # root "articles#index"
end
