Authority::Engine.routes.draw do
  resources :people do
    get 'viaf', on: :collection
  end

  resources :organization do
  end
end
