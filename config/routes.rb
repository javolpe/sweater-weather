Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do 
    namespace :v1 do 
      get 'backgrounds', to: 'backgrounds#index'

      get 'forecast', to: 'forecast#index'

      post 'users', to: 'users#create'

      get 'salaries', to: 'salaries#index'
    end
  end
end
