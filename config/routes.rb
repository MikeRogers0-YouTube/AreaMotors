Rails.application.routes.draw do
  resources :enquiries, only: [:index, :show]

  root to: redirect('/enquiries')
end
