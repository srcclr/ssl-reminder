SslReminder::Engine.routes.draw do
  resources :domains, only: %i(index create destroy) do
    member do
      get :scan
      put :toggle_notification
    end
  end

  root to: "domains#index"
end
