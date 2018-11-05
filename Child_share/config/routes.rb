Rails.application.routes.draw do

  # namespace :admin do
    # resources :dashboard, only: [:index]
  # end

  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end

  resources :book_requests
  resources :book_offers
  
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
    resources :reviews, shallow: true, only: [:new, :create, :index, :edit, :destroy] do
    end

  resources :children, only: [:new, :create]
  resources :offers do
    resources :book_offers, shallow: true
    get('/id/accept', { to: 'bookings#index'})
    get('/counter_request', { to: 'book_offers#new'})
    get('/bookings', { to: 'bookings#counter_offer'})
    # get('/id/apply_offer', { to: 'childshares#dashboard'})
  end

  resources :requests do
    get('/id/accept', { to: 'bookings#index'})
    # get('/request/new', { to: 'book_offers#new'})
    # get('/id/apply_request', { to: 'childshares#dashboard'})
  end
  
  resources :transactions, only: [:new, :update, :index, :show, :edit]
  resources :bookings
  get('/bookings', { to: 'bookings#counter_offer'})
  
  get('/', { to: 'welcome#index', as: 'home' })
#  get('/childshares_dashboard', { to: 'childshares#dashboard'})
  get('/job_board', { to: 'childshares#dashboard'})
  get('/make_request/:id', { to: 'offers#make_request'})
end
