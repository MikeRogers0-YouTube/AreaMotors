Rails.application.routes.draw do
  resources :enquiries, only: [:index, :show] do
    collection do
      post :fetch_new
    end

    member do
      patch :state_done
    end
  end

  root to: redirect('/enquiries')
end
