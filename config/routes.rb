Rails.application.routes.draw do
  resources :users, only: [:create, :new]
  resource :session, only: [:create, :destroy, :new]

  namespace :api, defaults: {format: :json} do
    resources :users, only: [:show, :index, :update] do
      resources :connections, only: :index
    end

    resources :connections, only: [:create, :update]
    get "/connections/sent", to: "connections#sent"
    get "/connections/received", to: "connections#received"

    resources :messages, only: [:create]
    get "/messages/sent", to: "messages#sent"
    get "/messages/received", to: "messages#received"

    resources :experiences, only: [:create, :update, :destroy, :show]

    get "/search", to: "static#search"
    get "/connections_search", to: "static#connections_search"
  end

  root "static#root"
end
