Rails.application.routes.draw do
  resources :slots do
    collection do
      post :import
    end
  end

  delete :slots, to: 'slots#destroy_all'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
