Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "pmtool#home"
  get('/pmtool', {to:"pmtool#home"})
  get('/pmtool/home', {to:"pmtool#home"})

  get('/pmtool/about', {to:"pmtool#about"})

  resources :projects do
    resources :tasks
    resources :discussions 
    resources :favourites, shallow: true, only: [:create, :destroy]
    get :favourited, on: :collection
  end

  resources :discussions do
    resources :comments
  end
  # resources :favourites, only:[:create, :destroy]
  resources :users, only:[:new, :create]
  resource :session, only:[:new, :create, :destroy]
end
