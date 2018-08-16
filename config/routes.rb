Rails.application.routes.draw do
  resources :customers, only: [:index, :show]

  resources :enquiries, only: [:index, :show, :edit, :update] do
    collection do
      post :fetch_new
    end

    member do
      patch :state_done
    end
  end

  root to: redirect('/enquiries')
end
