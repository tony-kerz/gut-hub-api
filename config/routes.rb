GutHubApi::Application.routes.draw do
  devise_for :users

  # tlk: users as resource for local admin features
  resources :users

  # tlk
  # ref: https://gist.github.com/AdrianTeh/3561310#file-cors-with-rails-devise-L62
  #
  #devise_for :users, :controllers => {:sessions => 'sessions'}

  # tlk: ajaxable authentication
  # ref: https://github.com/jesalg/RADD/blob/master/config/routes.rb#L58
  #
  #devise_scope :user do
#    post 'login' => 'sessions#create', :as => 'login'
#    post 'logout' => 'sessions#destroy', :as => 'logout'
#    get 'current_user' => 'sessions#show_current_user', :as => 'show_current_user'
#    get 'dummy' => 'sessions#dummy'
#  end

  get 'ingests' => 'ingests#index'
  post 'ingests' => 'ingests#create'

  # tlk: default
  root :to => 'application#home'

  # tlk: controller-less routes
  get '/home' => 'application#home'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  # root 'recipes#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  namespace :api do

    devise_scope :user do
      resources :sessions, only: [:create, :show, :destroy]
    end

    resources :recipes

    resources :others

  end

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
