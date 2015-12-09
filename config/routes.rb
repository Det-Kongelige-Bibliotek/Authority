Authority::Engine.routes.draw do
  resources :people do
    get 'viaf', on: :collection
  end
end
