class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def index
    @users = User.all.order('username ASC')
  end

  def show
    @user = User.find_by!(id: params.fetch(:id))
  end

  def create
    user_attributes = params.require(:username).permit(:email, :avatar)
  
    @user = User.new(user_attributes)

    if @user.valid?
      @user.save
      redirect_to users_url, notice: "User created successfully."

    else
      render "new"
    end
  end

  def edit
    @user = User.find_by!(id: params.fetch(:id))
  end

  def update
    @user = User.find_by!(id: params.fetch(:id))

    @user.username = params.fetch(:username)
    @user.email = params.fetch(:email)

    if @user.valid?
      @user.save

      redirect_to user_url(@user), notice: "User updated successfully."
    else
      redirect_to user_url(@user),  alert: "User failed to update successfully."
    end
  end

  def destroy
    @user = User.find_by!(id: params.fetch(:id))
    @user.destroy

    redirect_to users_url, notice: "User deleted successfully."
    end
end
