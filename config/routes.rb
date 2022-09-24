Rails.application.routes.draw do


   devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  namespace :admin do
    get "/" => "homes#top"
    resources :reviews, only: [:index, :show, :edit, :destroy, :update] do
      resources :comments, only:[:destroy]
    end
    resources :users, only: [:index, :show, :edit, :update]
  end

  devise_scope :user do
    post 'users/guest_sign_in' => 'public/sessions#guest_sign_in'
  end
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  scope module: :public do
    root:to => "homes#top"
    resources :reviews, only: [:new, :index, :show, :edit, :create, :destroy, :update] do
      resources :comments, only:[:create, :destroy]
    end
    get "/users/unsubscribe" => "users#unsubscribe"
    patch "/users/withdrawa" => "users#withdrawa"
    resources :users, only: [:show, :edit, :update]
    get "/search/review" => "reviews#search_review"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
