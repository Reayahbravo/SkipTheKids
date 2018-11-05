class ChildrenController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
    before_action :find_child, only: [:show, :new, :update, :edit, :update, :destroy]
    before_action :authorize_user!, only: [:edit, :update, :destroy]
  
    def new
      @child = Child.new
      redirect_to new_user_path(@user.id)
    end
  
    def create
      # render json: params

      @child = Child.new child_params
      # @child.user = current_user
  
      if @child.save
        @join = Join.new
        @join.user = current_user.id
        @join.child = child.id
        redirect_to child_path(@child.id)
      else
        render :new
      end
    end
  
    def show
      @child.save
  
      # @advertisement = Advertisement.new
      # @reviews = @child.reviews.order(created_at: :desc)
     
      # render :show
    end
  
    def index
      @children = Child.order(created_at: :desc)
      # render json: @children
  
      end
    end
  
    def edit
    end
  
    def update
      if @child.update(child_params)
        redirect_to child_path(@child.id)
      else
        render :edit
      end
    end
  
    def destroy
      @child.destroy
      redirect_to children_path
    end
  

    private
    def find_child
      @child = Child.find params[:id]
    end
  
    def child_params
      # Whenever your params contain an array, all the values
      # from the must be permitted as well. To do this,
      # use a key-value argument where the key is the name
      # of the input and the value is an empty array.
  
      params.require(:child).permit(:first_name, :last_name, :birthdate [])
    end
  
  
    def authorize_user!
      @child = Child.find params[:id]

      unless can?(:crud, @child)
        flash[:danger] = "Access Denied"
        redirect_to child_path(@child)
      end
    end
  end
