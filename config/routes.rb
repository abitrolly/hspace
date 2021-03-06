Rails.application.routes.draw do

  mount Tail::Engine, at: '/tail'

  root 'main#index'

  devise_for :devices
  devise_for :users

  resources :projects
  resources :devices, only: [:index, :show]
  get '/rules', to: 'main#rules'
  get '/calendar', to: 'main#calendar'
  get '/contacts', to: 'main#contacts'

  get '/spaceapi', to: 'main#spaceapi', defaults: {format: 'json'}

  resources :events, only: [:index] do
    collection do
      get 'add'
    end
  end
end
