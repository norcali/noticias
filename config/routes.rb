Agregador::Application.routes.draw do

  	devise_for :users, :path_names => {:sign_in => "login", :sign_out => "logout"}
  	resources :users

	root :to => "sites#index", :via => :get

	#Profiles
	match '/profiles/dashboard' => 'profiles#dashboard', :via => :get
	match 'profiles/:user_id' => 'profiles#show', :as => :profile

	#Sites
	match '/sites' => 'sites#index', :as => :sites, :via => :get
	match '/:id'=> 'sites#show', :as => :site, :via => :get
	match '/:id/edit' => 'sites#edit', :as => :edit_site, :via => :get
	match '/sites/new' => 'sites#new', :as => :new_site, :via => [:get, :post]
	match '/:id' => 'sites#update', :via => :put
	match '/:id' => 'sites#destroy', :via => :delete
	match '/:id/agregar' => 'sites#agregar', :as => :site_agregar, :via => [:get, :post]
	match '/sites' => 'sites#create', :via => :post

	#Posts
  	resources :sites, path: '' do
  		match ':ano/:mes/:dia/:id' => 'posts#show', :as => :site_post, :via => :get
    	resources :posts, only: [:destroy, :index, :create, :new, :edit, :update]
    	#match ':site_id' => 'posts#index', :as => :site_posts, :via => :get
		#match ':site_id' => 'posts#create', :via => :post
		#match ':site_id/post/new' => 'posts#new', :as => :new_site_post, :via => :get
		#match ':site_id/:id/edit' => 'posts#edit', :as => :edit_site_post, :via => :get
		#match ':site_id/:ano/mes/dia/:id' => 'posts#show', :as => :site_post, :via => :get
		#match ':site_id/:id' => 'posts#update', :via => :put
    end

	namespace :admin do
                match '/' => 'users#index'
                resources :users
    end

	match '*a', :to => 'sites#index'

  end
