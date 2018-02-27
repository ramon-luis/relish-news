class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def new
    @user = User.new
  end

  def show
    if logged_in?
      @user = current_user
    else
      redirect_to "/"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Relish News!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    if logged_in?
      @user = current_user
    else
      redirect_to "/"
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def delete
    @user = current_user
  end

  def destroy
    user = User.find(params[:id])
    log_out if logged_in?
    delete_favorites(user.id)
    user.delete
    redirect_to root_url
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def delete_favorites(user_id)
      Favorite.all.each do |favorite|
        if favorite.user_id == user_id
          favorite.delete
        end
      end
    end

end
