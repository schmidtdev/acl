Rails.application.routes.draw do
  devise_for :users, {
    path: '',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    }
  }

  get 'me', to: 'me#show'
  resources :users, only: %i[index show create update destroy]

  get "up" => "rails/health#show", as: :rails_health_check
end
