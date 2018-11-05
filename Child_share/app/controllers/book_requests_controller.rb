class BookRequestsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :destroy, :edit, :show]
    # before_action :find_offer, only: [:show, :edit, :update, :destroy]
    before_action :authorize_user!, only: [:edit, :update, :destroy]
      
    def new
      @book_request = BookRequest.new
      @request = Request.find params[:format]
    end
    
    def create 
      @book_request = BookRequest.new 
      @book_request.child_count = book_request_params[:child_count]
      @book_request.note = book_request_params[:note]
      @book_request.status = book_request_params[:status]
      request = Request.find book_request_params[:request]
      @book_request.request = request
      @book_request.user = current_user
      space = request.child_number
      bookings = BookRequest.find_by(request_id: book_request_params[:request])
      if bookings
        bookings.each do |booking|
          space -= booking.child_count
        end
      end
      if @book_request.child_count > (space)
        flash[:success] = "There aren't this many children to sit"
        redirect_to new_book_request_path(request.id) and return
      end
  
      if @book_request.save!
        flash[:success] = "Request for a sitter created!"
        redirect_to bookings_path
      else
        render :new
      end
    end

    def index
      @book_requests = BookRequest.viewable.order(created_at: :desc)
    end
  
    def show
    end
  
    def update
      @book_requests.update(book_request_params)
      redirect_to bookings_path
    end

    private
    def book_request_params
        params.require(:book_request)
        .permit(:status, :note, :user, :request, :child_count)
    end
end
