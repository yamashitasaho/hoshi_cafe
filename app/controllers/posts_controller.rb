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
      redirect_to posts_path, notice: t("defaults.flash_message.created", item: Post.model_name.human)
    else
      flash.now[:alert] = t("defaults.flash_message.not_created", item: Post.model_name.human)
      render :new, status: :unprocessable_entity
      # エラーで422が返される
    end
  end

  private

  def post_params
    params.require(:post).permit(:region, :shop_name, :rating, :body)
  end
end
