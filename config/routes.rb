Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  # OmniAuthの認証が成功したときに、コールバックとしてUsers::OmniauthCallbacksControllerが呼び出されるようにする設定
  root "static_pages#top" # TOPページ

  get 'terms', to: 'static_pages#terms' # 利用規約
  get 'privacy', to: 'static_pages#privacy' # プライバシーポリシー

  resources :posts, only: %i[index new create show edit destroy update] do # 投稿一覧,新規投稿,投稿詳細,編集,削除,更新
    collection do # postリソース全体にアクションを追加(IDがない)
      get :favorites # GET posts/favorites お気に入りされている投稿の一覧を出す
    end
  end

  resources :favorites, only: %i[create destroy] # お気に入り機能

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

  # プロフィール
  resources :profiles, only: %i[show edit update]

  # 開発環境でのメール確認
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
