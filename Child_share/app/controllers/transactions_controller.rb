class TransactionsController < ApplicationController
    before_action :authenticate_user!, except: [:show, :index]
    before_action :find_user, only: [:show, :edit, :update, :destroy]
    before_action :authorize!, only: [:edit, :update, :destroy]
    
    def new
        @transaction = Transaction.new
    end
    
    def create
    #     #render json: params
        @transaction = Transaction.new transaction_params

        if @transaction.save
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
        @transactions = Transaction.viewable.order(created_at: :desc)
    end

    def index
        
        # @transactions = User.Transactions.all
    end

    def show
        @transaction = Transaction.find params[:id]
    end
    
    private
    def transaction_params
        params.require(:transaction).permit(
          :first_name, :last_name, :email, :password, :password_confirmation
        )
    end

    def authorize_user!
        @transaction = Transaction.find params[:id]
    
        unless can?(:crud, @transaction)
          flash[:danger] = "Access Denied!"
          redirect_to user_path(@transaction.user)
        end
    end
end
