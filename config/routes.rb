Rails.application.routes.draw do

  root 'reservation#index'

  post "reservations/new", to: "reservations#new"

end
