Sup::Application.routes.draw do
  # Static Pages
  root 'static_pages#index'
  get '/notifications/:load' => 'static_pages#index', as: :notifications
  get '/about' => 'static_pages#about', as: :about
  get '/contact' => 'static_pages#contact', as: :contact
  post '/contact' => 'static_pages#submit_contact', as: :submit_contact
  
  # SignupRequest
  resources :signup_requests, only: [:create]  
  
  # User
  devise_for :users, :controllers => { :registrations => 'registrations' }
  get '/profile' => 'users#profile', as: :profile
  get '/edit-account-details' => 'users#edit_account_details', as: :edit_account_details
  get '/edit-play-schedule' => 'users#edit_play_schedule', as: :edit_play_schedule
  patch '/update-play-schedule' => 'users#update_play_schedule', as: :update_play_schedule
  get '/edit-game-preferences' => 'users#edit_game_preferences', as: :edit_game_preferences
  resources :users, only: [:update]
  
  # Match
  resources :matches, only: [:index]
  
  # FriendRequest
  resources :friend_requests, only: [:create,:show]
  get '/friend_requests/:id/accept' => 'friend_requests#accept', as: :accept_friend_request
  get '/friend_requests/:id/decline' => 'friend_requests#decline', as: :decline_friend_request
  
  # Games
  get '/games/platforms/:game_title' => 'games#platforms'
  post '/games/find_game' => 'games#find_game'
  
  # Frienships
  resources :friendships, only: [:index,:show]
  
  # Messages
  get '/messages/sent' => 'messages#sent', as: :sent_messages
  get '/messages/deleted' => 'messages#deleted', as: :deleted_messages
  delete '/messages/:id/archive' => 'messages#archive', as: :archive_message
  resources :messages, only: [:index,:create]
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

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
