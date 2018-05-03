Rails.application.routes.draw do
  devise_for :users
  mount DeviseExtension::Engine => "/devise_extension"
end
