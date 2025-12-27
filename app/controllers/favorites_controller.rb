class FavoritesController < ApplicationController
    def create
        @post = Post.find(params[:post_id])
        current_user.favorite(@post)
        redirect_to posts_path, notice: t('success')
    end

    def destroy
        @post = current_user.favorites.find(params[:id]).post
        current_user.unfavorite(@post)
        redirect_to posts_path, notice: t('success')
    end
end