# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

resources :project do
  match '/impersonate/start_impersonation', to: 'impersonate#start_impersonation',as: :start_impersonation , via:[:get,:post]
  match '/impersonate/stop_impersonation', to: 'impersonate#stop_impersonation',as: :stop_impersonation, via:[:get,:post]
  match '/impersonate/select_user', to: 'impersonate#select_user' ,as: :select_user, via:[:get,:post]
end