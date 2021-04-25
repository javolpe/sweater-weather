Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do 
    namespace :v1 do 
      get 'backgrounds', to: 'backgrounds#index'

      get 'forecast', to: 'forecast#index'

    end
  end
end
