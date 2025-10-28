Rails.application.routes.draw do
  devise_for :users
  root "static_pages#top" # TOPページ
  resources :posts, only: %i[index new create show edit destroy update] # 投稿一覧,新規投稿,投稿詳細,編集,削除,更新

  # 店舗検索用エンドポイント（Ajax用）
  resources :shops, only: [] do
    collection do # 全ての店舗から検索
      get :search_place # GET /shops/search_place?query=店舗名
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
