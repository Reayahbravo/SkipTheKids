class ReviewsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_review, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user!, only: [:edit, :update, :destroy]
    
    def new
        # user = User.find params[:user_id]
        @review = Review.new #review_params
        @review.user = @user
        @review.user = current_user
        # review = user.review.build(user: current_user)

        # @review = Review.new(@user, review)
    

    end

    def edit
    end
    
    def create
        # @user = User.find params[:user_id]
        @review = Review.new review_params
        @review.user = @user
        @review.user = current_user
    
        if @review.save
            if @user.user.present?
            # This sends mail synchronously
            # which will block your rails process:
            # ReviewMailer
            #   .notify_user_owner(@review)
            #   .deliver_now
    
            #   # This sends mail asynchronously using
            #   # your ActiveJob setup which will not
            #   # block the rails process. This is
            #   # best practice.
            #   ReviewMailer
            #     .notify_user_owner(@review)
            #     .deliver_later
            #     # .deliver_later(wait: 10.minutes)
            #     # .deliver_later(run_at: 1.day.from_now)
            #     # `deliver_later` accepts the same arguments
            #     # as `set` for ActiveJobs.
            redirect_to new_review_path
            else
                if can? :crud, @user
                    @reviews = @user.reviews.order(created_at: :desc)
                else
                    @reviews = @user.reviews.where(hidden: false).order(created_at: :desc)
                end
            render "users/show"
            end
        end
    end

    def index
        # @reviews = Review.user.all(created_at: :desc)
        @requests = Request.viewable.order(created_at: :desc)
    end
  
    def destroy
      @review ||= Review.find params[:id]
      @review.destroy
  
      redirect_to user_path(@review.user)
    end
  
    private
    def review_params
      params.require(:review).permit(:body, :rating)
    end

    def find_review
        # @review = Review.find params[:id]
    end
  
    def authorize_user!
      @review = Review.find params[:id]
  
      unless can?(:crud, @review)
        flash[:danger] = "Access Denied!"
        redirect_to user_path(@review.user)
      end
    end
end
