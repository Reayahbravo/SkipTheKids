class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_user, only: [:show, :new, :create, :edit, :update, :destroy]
  # before_action :find_booking
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  
  def new
    @booking = Booking.new
  end
  
  def create 
    @booking = Booking.new
    @booking.user = current_user
    # @booking.user = current_user(@user)
    @offer = Offer.new
    @request = Request.new
    @booking = current_user.bookings.new(booking_params)
    
    if @booking.save!

      o = Offer.find params[:offer_id]
      if can? :post, o
          # o is shorthand for offer_path
          o.post!
          redirect_to bookings_path, notice: 'Offer posted!'
      else
          head :unauthorized
      end
  #   @booking = Booking.new booking_params
  #   @booking.user = current_user

  #   if @booking.save
  #     redirect_to booking_path(@booking.id)
  #   else
  #     render :new
  #   end
    end
  end

  def index
    # @offers = Offer.find current_user

    # my_requests = Request.where({request_id: current_user})
    # my_request_ids = Request.where({user_id: current_user}).pluck(:id)

    # @bookings = Booking.where({request_id: my_request_ids}).order(created_at: :desc)
    # @bookings = Booking.where({request_id: current_user}).order(created_at: :desc)
    @offers = Offer.where({user_id: current_user}).order(proposed_from: :desc)
    @requests = Request.where({user_id: current_user}).order(proposed_from: :desc)

    your_bookings = BookOffer.where({user_id: current_user})
    your_bookings = your_bookings.to_a
    ids = Array.new
    if your_bookings
      if your_bookings.kind_of?(Array)
        your_bookings.each do |booking|
          ids.push(booking.offer.id)
        end
      elsif
        ids.push(your_booking.offer.id)
      end
    end
    @offer_bookings = Offer.where(id: ids)
    @offer_bookings = @offer_bookings.to_a

    your_bookings = BookRequest.where({user_id: current_user})
    your_bookings1 = your_bookings1.to_a
    ids1 = Array.new
    if your_bookings1
      if your_bookings1.kind_of?(Array)
        your_bookings1.each do |booking|
          ids1.push(booking.offer.id)
        end
      elsif
          ids1.push(your_booking.request.id)
      end
    end
    @request_bookings = Request.where(id: ids1)
    @request_bookings = @request_bookings.to_a
    puts 'TESTING THIS NOW PLEASE LOOK'
    puts your_bookings1.length
    @request_bookings.each do [test]
      puts test.id
    end
  end

  def show
    
    # render json params
    @booking.save

    @booking = Booking.new
    @offers = @booking.offers.order(created_at: :desc)
    # render :show
    
  end
  
  def edit
  end

  def update
    if @booking.update(booking_params)
      redirect_to booking_path(@booking.id)
    else
      render :edit
    end
  end
  
  def destroy
    @booking.destroy
    redirect_to bookings_path
  end

  # def status
  #   if accept == pending

  # end

  def counter_offer
    @request = Request.new
    @request.child_number = current_user.children.count
  end

  private
  def find_user
    # if params[:id]
      @user = User.find current_user.id
    # else
    #   offer = Offer.find :id => offer
    #   @user = User.find :id => offer.user
    # end


    # @user = current_user(@booking)
  end

  # def find_booking
  #   @booking = Booking.find params[:id]
  # end
  
  def authorize_user!
    unless can?(:crud, @booking)
      flash[:danger] = "Access Denied"
      redirect_to booking_path(@booking)
    end
  end
end
