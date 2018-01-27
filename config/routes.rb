Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'users#index'
  
  post "/users/sign_in" => "users#sign_in", as: "user_sign_in"
  get "/users/get_sign_in" => "users#get_sign_in", as: "user_get_sign_in"
  get "/users/sign_out" => "users#sign_out", as: "user_sign_out"

  resources :users, except: :index

  get "/auth/:provider/callback" => "users#create_from_omniauth"

end
