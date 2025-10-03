class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]
  def index
    @posts = Post.includes(:user)
  end

  def new
    @post = Post.new(rating: 3)
  end
  # デフォルトで3点を設定

  def create
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
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: t("defaults.flash_message.updated", item: Post.model_name.human), status: :see_other
    else
      flash.now[:alert] = t("defaults.flash_message.not_updated", item: Post.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    redirect_to posts_path, notice: t('defaults.flash_message.deleted', item: Post.model_name.human), status: :see_other
  end
  # HTTPステータスコード 303 "See Other" を送信

  private

  def post_params
    params.require(:post).permit(:region, :shop_name, :rating, :body)
  end
end
