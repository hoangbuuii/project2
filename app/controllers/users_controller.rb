class UsersController < ApplicationController
  before_action :load_user, except: %i(index)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.select_id_name_email.order_created_at.paginate page: 
      params[:page], per_page: Settings.per_page
  end

  def show
    @posts = @user.posts.order_by_created_at_desc
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "user_deleted"
    else
      flash[:danger] = t "user_cannot_be_deleted"
    end
    redirect_to users_url
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:warning] = t "cannot_find_user"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to(root_url) unless @user.current_user? @user
   end

  def admin_user
    redirect_to(root_url) unless current_user.is_admin?
  end
end
