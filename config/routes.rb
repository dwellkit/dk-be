Rails.application.routes.draw do

  devise_for :users, :controllers => { :registrations => "registrations", :sessions => "sessions"}
  # IF USERS WANT AUTH WITHOUT TOKEN DEVISE ROUTES MUST COME FIRST

  # ROUTES FOR PROPERTIES
  post 'property/add', to: 'property#add'
  patch 'property/:id', to: 'property#edit'
  patch 'property/:id/reimport', to: 'property#reimport'

  # ROUTES FOR ROOMS
  post 'property/:id/room', to: 'room#add'
  patch 'property/:id/room/:rid', to: 'room#edit'

  # ROUTES FOR CONTACTS
  post '/contacts', to: 'contacts#create'

  #ROUTES FOR WARRANTIES
  post '/warranties', to: 'warranties#create'
  # post '/warranties/contact', to: 'warranties#contact'

  # later might want to namespace the api...
  # namespace :api do
  #   mount_devise_token_auth_for 'User', at: 'auth'
  # end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
