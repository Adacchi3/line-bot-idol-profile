Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :apis do
    post '/callback' => 'linebot#callback'
  end
end
