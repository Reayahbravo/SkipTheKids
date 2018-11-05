class OffersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy, :edit, :show]
  before_action :find_offer, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
    
  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new offer_params
    @offer.user = current_user

    if @offer.save!
      flash[:success] = "Offer to watch child created!"
      redirect_to job_board_path
    else
      render :new
    end
  end
  
  def index
    @offers = Offer.viewable.order(created_at: :desc)
  end

  def show
    prev_book_offer = BookOffer.find_by(user_id: current_user, offer_id: params[:id])
    if prev_book_offer
      @has_booking = TRUE
    end

    postuser = User.find @offer.user_id
    @alias = postuser.alias
    @offer = Offer.find params[:id]
    @your_booking = BookOffer.find_by(user_id: current_user, offer_id: params[:id])
    @others_offers = BookOffer.find_by(offer_id: params[:id])
    
    @space = @offer.max_child_number
    bookings = BookOffer.find_by(offer_id: params[:id], status: 'confirmed')
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
    @booking = BookOffer.find book_offer_params[:id]
    if params[:commit] == 'Cancel'
      status = 'cancelled'
    elsif params[:commit] == 'Confirm'
      status = 'confirmed'
    end
    @booking.update_attribute(:status, status)
    # @booking.status = book_offer_params[:status]
    # @book_offer.update(@booking)
    flash[:success] = "Update submitted!"
    redirect_to bookings_path
    # offer.update(offer_params)
    # redirect_to childshares_dashboard_path
  end

  def counter_offer
    @offer = Offer.find params[:id]
    @child = Child.find params[:id]
    1.times { @user.children.build }
    if @child.offer = Offer

      if offer.update(@child)
      # offer_id.accept do update state aasm
      end
    end
  end

    def make_request
    
    end

  # def accept
  #   o = Offer.find params[:question_id]
  #   if can? :accept, o
  #     o.accept!
  #     redirect_to o, notice: 'Offer Accepted!'
  #   else
  #     head :unauthorized
  #   end
  # end

  def destroy
    if can?(:delete, offer)
      offer.destroy
      flash[:success] = "Offer to watch child deleted!"
      redirect_to offers_path
    else
      flash[:danger] = "Access Denied!"
      redirect_to offer_path(offer)
    end
  end

  def book_offer1
    @test = "This is a test"
    render :partial=>'book_offer1', :something => @test
  end
  
  private

  def find_offer
    @offer = Offer.find params[:id]
  end

  def offer_params
    params.require(:offer)
      .permit(:proposed_from, :proposed_to, :max_child_number, :note,)
  end

  def authorize_user!
    unless can?(:crud, @offer)
      flash[:danger] = "Access Denied"
      redirect_to offer_path(@offer)
    end
  end
  
  def book_offer_params
    params.require(:book_offer)
      .permit(:id)
  end

end
