class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]
  def index
    @posts = Post.includes(:user)
  end
end
