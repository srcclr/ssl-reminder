SslReminder::Engine.routes.draw do
  resources :domains, only: :index

  root to: "domains#index"
end
