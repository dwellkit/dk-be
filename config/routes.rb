Rails.application.routes.draw do

  devise_for :users, :controllers => { :registrations => "registrations", :sessions => "sessions"}

  # ROUTES FOR USER
  get 'users/info', to: 'users#show'

  #REFACTOR
  resources :properties do
    post '/pic', to: 'properties#pic'
    post '/pictures', to: 'pictures#add_property_image'

    resources :items, :except => [:create, :new, :show] do

      #ADD ITEM PICTURES
      post '/pictures', to: 'pictures#add_item_image'
      resources :warranties
      
    end
    resources :contacts, :insurances, :events, :warranties, :contacts

    post 'items', to: 'items#create_property_item'

    #PROPERTY IMAGES
    post '/images', to: 'properties#add_image'
    get '/images', to: 'properties#show_images'

    #REIMPORT PROPERTY
    patch '/reimport', to: 'properties#reimport'

    #ITEM IMAGES
    post 'items/:item_id/images', to: 'items#add_image'
    get 'items/:item_id/images', to: 'items#show_images'

    resources :rooms do

      #ROOM IMAGES
      post '/images', to: 'pictures#add_room_image'
      get '/images', to: 'rooms#show_images'

      resources :items do
        post '/images', to: 'items#add_image'
        get '/images', to: 'items#show_images'

        resources :warranties

      end
    end
  end
 end
