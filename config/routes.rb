Rails.application.routes.draw do

  root to: 'home#top'
  get '/home/about' => 'home#about'

  devise_for :users

  resources :books, except: [:new] do
  	resource :favorites, only: [:create, :destroy]
    resource :book_comments, only: [:create]
   end
    resources :book_comments, only: [:destroy]
  resources :users, only: [:index, :show, :edit, :update, :destroy]  do
    member do
     get :following, :followers
    end
  end

post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
