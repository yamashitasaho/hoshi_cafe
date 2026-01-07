class ProfilesController < ApplicationController

  def show
    @user = User.includes(:posts, :favorite_posts).find(params[:id])
    # 他の人のプロフィールも見れるようにする
    # favorite_postsを追加
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    begin
      # 画像を処理して更新
      @user.profile_image = @user.process_and_transform_image(params[:user][:profile_image], 400) if params[:user][:profile_image].present?

      if @user.update(profile_params)
        redirect_to profile_path, notice: t("defaults.flash_message.updated", item: User.model_name.human), status: :see_other
      else
        flash.now[:alert] = t("defaults.flash_message.not_updated", item: User.model_name.human)
        render :edit, status: :unprocessable_entity
      end

      rescue ImageProcessable::ImageProcessingError => e
        flash.now[:alert] = e.message
        render :edit
      end
  end

  private

  def profile_params
    params.require(:user).permit(:nickname, :region, :introduction)
    # profile_imageはwebpが上書きされてしまうので含めない
  end
end
