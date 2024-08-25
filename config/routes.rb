Rails.application.routes.draw do
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check

  scope "/l/:language_iso" do
    resources :words, path: "", only: [:index, :show, :destroy], param: :value
  end

  resources :translations, path: "/t", only: [:new, :create, :destroy]
  resources :exercises, path: "/e", only: [:index, :create, :show], param: :url_identifier do
    resources :items, path: "/i", only: [:show, :edit, :update], param: :url_identifier, module: :exercises
  end

  resources :mojinizers, only: :show, param: :value

  root to: "home#index"
end
