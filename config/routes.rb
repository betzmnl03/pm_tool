Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "projects#index"
  get('/pmtool/projects', {to:"pmtool#home"})
  get('/pmtool/projects', {to:"pmtool#home"})

  get('/pmtool/projects/myprojects', {to:"projects#myprojects"})
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
  resources :members, only:[:index, :show]
 
  resources :tags, only:[:index, :show]
  resources :users, only:[:new, :create]
  resource :session, only:[:new, :create, :destroy]
end
