Authority::Engine.routes.draw do
  resources :people do
    get 'viaf', on: :collection
  end

  get 'finder/:q' => 'finder#search'
  get 'finder/search/:q', to: 'finder#search'
  get 'finder/getobj/:id', to: 'finder#get_obj'
  get 'finder/searchbysameasuri/', to: 'finder#search_by_same_as_uri'
end
