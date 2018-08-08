Rails.application.routes.draw do
  resources :enquiries, only: [:index, :show]
end
