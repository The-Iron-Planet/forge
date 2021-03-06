Rails.application.routes.draw do

  resources :job_posts, except: [:show]
  resources :resources do
    resources :comments, module: :resources
  end
  resources :events do
    resources :comments, module: :events
  end

  resources :positions
  resources :courses
  resources :curricula
  resources :campuses
  devise_for :users

  get '/first_login' => 'users#first_login', as: :first_login
  # get '/dashboard' => 'users#dashboard', as: :dashboard


  root 'users#dashboard'
  post 'search' => 'users#index'
  post 'search_events' => 'events#index'
  post 'search_jobs' => 'job_posts#index'
  post 'search_resources' => 'resources#index'
  get 'my_job_posts' => 'job_posts#my_job_posts'
  get 'my_events' => 'events#my_events'
  get 'my_resources' => 'resources#my_resources'
  get 'add_students/:id' => 'courses#add_students', as: :add_students
  patch 'add_students/:id' => 'courses#add_students'
  get 'work_history/:id' => 'users#work_history', as: :work_history
  patch 'work_history/:id' => 'users#work_history'


  resources :users do
    member do
      get 'edit_password'
    end
  end

  resource :user, only: [:edit_password] do
    collection do
      patch 'update_password'
    end
  end

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end


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
