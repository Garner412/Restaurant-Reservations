Rails.application.routes.draw do

  root 'reservations#index'

  post "reservations/new", to: "reservations#create"

end
