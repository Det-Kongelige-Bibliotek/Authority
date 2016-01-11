Authority::Engine.routes.draw do
  get 'authority/organization'

  resources :people do
    get 'viaf', on: :collection
  end
end
