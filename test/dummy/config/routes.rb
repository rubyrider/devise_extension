Rails.application.routes.draw do
  mount DeviseExtension::Engine => "/devise_extension"
end
