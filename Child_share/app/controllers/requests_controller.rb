class RequestsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :edit, :show]
  before_action :find_request, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def new
    @request = Request.new
  end

  def create
    @request = Request.new request_params
    @request.user = current_user

    if @request.save
      flash[:success] = "Request for child watcher need created!"
      redirect_to job_board_path
    else
      render :new
    end
  end
  
  def index
    @requests = Request.viewable.order(created_at: :desc)
  end

  def show
    prev_book_request = BookRequest.find_by(user_id: current_user, request_id: params[:id])
    if prev_book_request
      @has_booking = TRUE
    end

    postuser = User.find @request.user_id
    @alias = postuser.alias
    @request = Request.find params[:id]
    @your_booking = BookRequest.find_by(user_id: current_user, request_id: params[:id])
    @others_requests = BookRequest.find_by(request_id: params[:id])
    
    @space = @request.child_number
    bookings = BookRequest.find_by(request_id: params[:id], status: 'confirmed')
    if bookings
      if bookings.kind_of?(Array)
        bookings.each do |booking|
          @space -= booking.child_count
        end
      else
        @space -= bookings.child_count
      end
    end
  end
  
  def edit
  end

  def update
    request.update(request_params)
  end

  def destroy

    if can?(:delete, request)
      request.destroy
      flash[:success] = "Request for child watcher need deleted!"
      redirect_to requests_path
    else
      flash[:danger] = "Access Denied!"
      redirect_to request_path(request)
    end
  end

  def counter_request
    @request = Request.new
    @request.child_number = current_user.children.count
    redirect to offer_counter_request_path
  end
  
  private
  def find_request
    @request = Request.find params[:id]
  end

  def request_params
    params.require(:request)
    .permit(:proposed_from, :proposed_to, :child_number, :note,)
  end

  def authorize_user!
    unless can?(:crud, @request)
      flash[:danger] = "Access Denied"
      redirect_to request_path(@request)
    end
  end
end

