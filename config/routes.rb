Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :families
  resources :questions
  resources :users

  resources :patient_sessions
  resources :session_questions

end
