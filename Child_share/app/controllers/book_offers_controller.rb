class BookOffersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :edit, :show]
  # before_action :find_offer, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
    
  def new
    @book_offer = BookOffer.new
    puts @book_offer.offer.class
    @offer = Offer.find params[:offer_id]
  end
  
  def create 
    puts (params[:offer_id])
    puts "we are getting to this spot"
    @book_offer = BookOffer.new 
    @book_offer.child_count = book_offer_params[:child_count]
    @book_offer.note = book_offer_params[:note]
    @book_offer.status = book_offer_params[:status]
    offer = Offer.find book_offer_params[:offer]
    @book_offer.offer = Offer.find book_offer_params[:offer]
    @book_offer.user = current_user
    # @book_offer.offer = @offer
    space = offer.max_child_number
    bookings = BookOffer.find_by(offer_id: params[:offer_id])
    if bookings
      bookings.each do |booking|
        space -= booking.child_count
      end
    end
    if @book_offer.child_count > (space)
      flash[:success] = "Not enough room left"
      redirect_to offer_counter_request_path(offer.id) and return
    end

    if @book_offer.save!
      flash[:success] = "Request for a sitter created!"
      redirect_to bookings_path
    else
      render :new
    end
  end

  def index
    @book_offers = BookOffer.viewable.order(created_at: :desc)
  end

  def show
  end

  def update
    @book_offer.update(book_offer_params)
    redirect_to bookings_path
  end

  def extshow
    @book_offer = BookOffer.find_by(user_id: current_user, offer_id: params[:offer_id])
    @alias = current_user.alias
  end
  
  private
  def offer_params
    params.require(:offer_id)
  end
  
  def book_offer_params
    params.require(:book_offer)
      .permit(:user, :offer, :status, :child_count, :note)
  end

  
end
