SslReminder::Engine.routes.draw do
  resources :domains, only: %i(index create destroy)

  root to: "domains#index"
end
