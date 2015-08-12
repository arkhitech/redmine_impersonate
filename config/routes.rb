# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

resources :projects do
  resource :impersonate, only: [] do
    collection do
      post 'start_impersonation'
      post 'stop_impersonation'
      get 'select_user'
    end
  end
end