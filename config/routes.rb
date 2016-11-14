Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/spoty' => 'spoty#index', as: 'spoty'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
  }

  devise_scope :user do
    get 'login', :to => 'users/sessions#new', :as => :new_user_session
    get 'logout', :to => 'users/sessions#destroy', :as => :destroy_user_session
  end
end
