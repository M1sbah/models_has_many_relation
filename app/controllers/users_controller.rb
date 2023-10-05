class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def find_user
    @user = User.find_by(name: params[:name])
    if @user.present?
      redirect_to user_path(@user)
    end
  end
  

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.turbo_stream do 
          render turbo_stream: [
            turbo_stream.replace("form",partial: 'users/form', locals: {url: users_path} ),
            turbo_stream.replace("users-list",partial: 'users/users_list', locals: {users: User.all} )
          ]
        end
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.destroy
        format.turbo_stream { render turbo_stream: turbo_stream.remove("user-#{@user.id}")}
      end
    end

  end


  private
  def user_params
    params.require(:user).permit(:name, :address)
  end

end
