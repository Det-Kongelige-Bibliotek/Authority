Authority::Engine.routes.draw do
  resources :people do
    get 'viaf', on: :collection
  end

  resources :organizations

  get 'finder' => 'finder#search'
  get 'finder/search/:model/', to: 'finder#search'
  get 'finder/getobj/:id', to: 'finder#get_obj'
  get 'finder/searchbysameasuri/', to: 'finder#search_by_same_as_uri'
end
