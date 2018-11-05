class UsersController < ApplicationController
  def new
      @user = User.new
      @child = Child.new
      5.times { @user.children.build }
  end
    
  def create
#     #render json: params
    @user = User.new user_params
  
    if @user.save
        # The `session` is an object useable in controllers
    # that uses cookies to store encrypted data. To sign
    # in a user, we store their `user_id` in the session for
    # later retrieval.
    session[:user_id] = @user.id
    redirect_to home_path
    
    else
      render :new
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]

    if @user.update(user_params)

        redirect_to user_path(@user.id)
    else
        render :edit
    end 
  end

      def destroy
        @user = User.find params[:id]
        @user.destroy
        flash[:success] = "User removed"
        # redirect_to admin_dashboard_users_path
    end
    
      private
      def user_params
        params.require(:user).permit(
          :first_name, :last_name, :email, :password, :password_confirmation, :parent, :alias, :location, {children_attributes: [:details, :id, :_destroy]}
        )
      end
  end
