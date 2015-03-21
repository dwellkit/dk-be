Rails.application.routes.draw do

  devise_for :users, :controllers => { :registrations => "registrations", :sessions => "sessions"}

  # ROUTES FOR PROPERTIES
  # post 'properties/add', to: 'properties#add'
  # patch 'properties/:id', to: 'properties#edit'
  # patch 'properties/:id/reimport', to: 'properties#reimport'
  # post 'properties/:id/pic', to: 'properties#pic'
  # get 'properties/:id', to: 'properties#show'

  # ROUTES FOR USER
  get 'users/info', to: 'users#show'

  #REFACTOR
  resources :properties do
    resources :items, :except => [:create, :new, :show]
    resources :contacts, :insurances, :events

    post 'items', to: 'items#create_property_item'

    #PROPERTY IMAGES
    post '/images', to: 'properties#add_image'
    get '/images', to: 'properties#show_images'
    delete '/images/:image_id', to: 'properties#delete_image'

    #REIMPORT PROPERTY
    patch '/reimport', to: 'properties#reimport'

    #PROFILE PIC
    post '/:id/profile', to: 'properties#pic'


    #ITEM IMAGES
    post 'items/:item_id/images', to: 'items#add_image'
    get 'items/:item_id/images', to: 'items#show_images'

    resources :rooms do

      #ROOM IMAGES
      post '/images', to: 'rooms#add_images'
      get '/images', to: 'rooms#show_images'

      resources :items do
        post '/images', to: 'items#add_image'
        get '/images', to: 'items#show_images'

        resources :warranties

      end
    end
  end

  # ROUTES FOR ROOMS
  # post 'properties/:id/rooms', to: 'rooms#add'
  # patch 'properties/:id/rooms/:rid', to: 'rooms#update'
  # delete 'properties/:id/rooms/:rid', to: 'rooms#destroy'

  # ROUTES FOR ITEMS
  # post 'properties/:id/rooms/:rid/items', to: 'items#add_room_item'
  # post 'properties/:id/items', to: 'items#add_property_item'
  # patch 'properties/:id/rooms/:rid/items/:iid', to: 'items#edit'
  # delete 'items/:iid', to: 'items#destroy'
  # get 'properties/:id/rooms/:rid/items', to: 'items#room_items'
  # get 'properties/:id/items', to: 'items#property_items'


  # ROUTES FOR CONTACTS
  # post '/contacts', to: 'contacts#create'
  # get 'contacts/:cid', to: 'contacts#show'
  # patch 'contacts/:cid', to: 'contacts#update'
  # delete 'contacts/:cid', to: 'contacts#destroy'
  # get 'properties/:id/contacts', to: 'contacts#property_contacts'
  # post 'properties/:id/contacts', to: 'contacts#create'

  #ROUTES FOR WARRANTIES
  # post 'properties/:id/items/:iid/warranties', to: 'warranties#create'
  # patch 'properties/:id/items/:iid/warranties/:wid/contacts/:cid', to: 'warranties#add_contact'
  # get 'properties/:id/warranties', to: 'warranties#index'
  # delete 'warranties/:wid', to: 'warranties#delete'
  # post '/warranties/contact', to: 'warranties#contact'

  #ROUTES FOR INSURANCES
  # post 'items/:iid/insurances', to: 'insurances#create'
  # patch 'items/:iid/insurances/:pid/contacts/:cid', to: 'insurances#add_contact'

  #ROUTES FOR EMAILS
  # get 'events/email', to: 'events#email'
  # post 'events', to: 'events#create'
  # get 'events', to: 'events#show'
  # delete 'events/:eid', to: 'events#destroy'

 end
