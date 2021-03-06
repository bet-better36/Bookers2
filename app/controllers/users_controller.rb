class UsersController < ApplicationController

   def following
      @user  = User.find(params[:id])
     @users = @user.following
      render 'relationships/show_following'
  end

    def followers
    @user  = User.find(params[:id])
   @users = @user.follower
    render 'relationships/show_follower'
  end

  def index
    @book = Book.new
    @users = User.all
  end

  def show
    @bookn = Book.new
    @user = User.find(params[:id])
    # @user = current_user
    # @books = Book.all
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
      else
        render :edit
      end
  end

   def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "You have deleted user successfully."
    redirect_to users_path
  end


  private
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
