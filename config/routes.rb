Rails.application.routes.draw do

  resources :profile_educations
  get 'profile_educations/swap/:id', to: 'profile_educations#swap'
  get 'profile_educations/add/:profile_id', to: 'profile_educations#add'

  resources :profile_contacts
  get 'profile_contact/swap/:id', to: 'profile_contacts#swap'
  get 'profile_contacts/add/:profile_id', to: 'profile_contacts#add'

  resources :profile_experiences
  get 'profile_experience/swap/:id', to: 'profile_experiences#swap'
  get 'profile_experiences/add/:profile_id', to: 'profile_experiences#add'

  resources :profile_introductions
  get 'profile_introduction/swap/:id', to: 'profile_introductions#swap'
  get 'profile_introduction/add/:profile_id', to: 'profile_introductions#add'

  resources :profiles
  get 'profiles/additional_info/:id', to: 'profiles#additional_info'
  get 'profiles/switch/:id', to: 'profiles#switch'
  get 'profiles/edit_bio/:id', to: 'profiles#edit_bio'
  get 'profiles/edit_location/:id', to: 'profiles#edit_location'
  get 'profiles/new/:id', to: 'profiles#new', as: 'profile_initialize'
  
  resources :user_follows

  resources :activities

  resources :user_to_interests

  resources :user_to_skills

  resources :interests

  resources :skills

  get 'control_panel/home'
  get 'user', to: 'users#show'
  get 'profile/:username', to: 'profiles#show'

  resources :user_to_project_tasks

  resources :project_tasks

  resources :project_to_tags

  resources :project_tags

  resources :user_project_follows

  resources :user_to_projects

  # get 'projects/new'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  get 'auth/:provider/callback', to: 'sessions#omniauthcreate'
  get 'log_out' => 'sessions#destroy', as: 'log_out'
  get 'log_in' => 'sessions#new', as: 'log_in'
  get 'sign_up' => 'users#new', as: 'sign_up'
  root 'welcome#index'
  resources :users
  resources :notifications
  resources :requests
  resources :sessions
  resources :password_resets
  resources :projects do
    resources :positions
  end
  get 'project/switch/:id', to: 'projects#switch'
  resources :project_posts
  post 'join_project' => 'projects#join_request', as: 'join_project'

  # THIS IS FOR POSTS.
  resources :project_comments
  post 'accept_project' => 'projects#accept_request', as: 'accept_project'



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
