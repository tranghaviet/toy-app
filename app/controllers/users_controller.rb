class UsersController < ApplicationController
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

  def update
  end

  def destroy
  end

  private
    def user_params
    	# bat buộc trong params phai có key là user
    	# khi khong co key user thi Rails bao error -> co the dung fetch()
    	# trong key user chi cho phép name và email, pass va pass_confirm
    	params.require(:user).permit(:name, :email, :password, :password_confirm)
    end
end
