class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :up]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
    # render template: "users/new" -> ko can vi Rails tu tim den template new
    # trong thu muc views/users
  end
  
  def show
    @user = User.find(params[:id])
    # debugger
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      # to display the message on the first page after the redirect
      flash[:success] = "Welcome to toy app"
      redirect_to @user # ~ redirect_to user_url(@user)
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_path
  end
  
  private
  def user_params
    # bat buộc trong params phai có key là user
    # khi khong co key user thi Rails bao error -> co the dung fetch()
    # trong key user chi cho phép name và email, pass va pass_confirm
    params.require(:user).permit(:name, :email, :password, :password_confirm)
  end
  
  # Confirm a logged-in user
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_path
    end
  end

  # Confirms the correct user
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end
  
  # Confirms an admin user
  def admin_user
    redirect_to(login_path) unless current_user.admin?
  end

end
