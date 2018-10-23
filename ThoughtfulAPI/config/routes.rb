Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :families
  resources :questions
  resources :users

  get '/patient_sessions', to: 'patient_sessions#index'
  post '/patient_sessions', to: 'patient_sessions#create'
  get '/patient_sessions/:id', to: 'patient_sessions#show'

  get '/session_questions', to: 'session_questions#index'
  post '/session_questions', to: 'session_questions#create'
  get '/session_questions/:id', to: 'session_questions#show'

end
