class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]
  before_action :set_user_post, only: [ :edit, :update, :destroy ]
  # 自分の投稿かをチェック

  def index
    @posts = Post.includes(:user)
  end

  def new
    @post = Post.new(rating: 3)
  end
  # デフォルトで3点を設定

  def create
    setup_shop

    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: t("defaults.flash_message.created", item: Post.model_name.human), status: :see_other
    else
      flash.now[:alert] = t("defaults.flash_message.not_created", item: Post.model_name.human)
      render :new, status: :unprocessable_entity
      # エラーで422が返される
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    # @postは set_user_post で既にセット済み
  end

  def update
    setup_shop
    # @postは set_user_post で既にセット済み
    if @post.update(post_params)
      redirect_to post_path(@post), notice: t("defaults.flash_message.updated", item: Post.model_name.human), status: :see_other
    else
      flash.now[:alert] = t("defaults.flash_message.not_updated", item: Post.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy!  # set_user_postで取得済みの@postを使う
    redirect_to posts_path, notice: t("defaults.flash_message.deleted", item: Post.model_name.human), status: :see_other
  end
  # HTTPステータスコード 303 "See Other" を送信

  private

  def post_params
    params.require(:post).permit(:region, :shop_name, :rating, :body, :shop_id)
  end

  def set_user_post
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to posts_path, alert: t("defaults.errors.unauthorized_access") unless @post
  end

  def setup_shop
    return unless params[:post][:place_id].present?

    shop = Shop.find_or_create_by(place_id: params[:post][:place_id]) do |s|
      s.name = params[:post][:shop_name]
      s.address = params[:post][:address]
      s.google_map_url = params[:post][:google_map_url]
      s.phone_number = params[:post][:phone_number]
      s.business_hours = params[:post][:business_hours]
    end

    params[:post][:shop_id] = shop.id
  end
end
