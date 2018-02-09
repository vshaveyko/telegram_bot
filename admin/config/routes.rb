Rails.application.routes.draw do

  if defined?(ActiveAdmin)
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
