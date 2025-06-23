Rails.application.routes.draw do
  devise_for :users, controllers: {
    # UserのSessionsControllerには、Users::SessionsControllerを利用する。他のコントローラーも同じように修正する。
    sessions:      "users/sessions",
    passwords:     "users/passwords",
    registrations: "users/registrations"
  }

  devise_scope :user do
    root to: "users/sessions#new"
  end

  resources :homes, only: %i[ index ]

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
