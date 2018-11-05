class Ability
  include CanCan::Ability

  def initialize(user)

    alias_action(:create, :read, :update, :delete, to: :crud)

    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.admin?
      # When using :all instead of a class name, the rule
      # will apply to ALL classes in your program.

      # In the rule below, this means that the admin user
      # can manage EVERYTHING!
      can :manage, :all
    else
      can :read, :all
    end


    can(:crud, Child) do |child|
      user == answer.user
    end

    can(:crud, Review) do |review|
      user == review.user
    end

    can(:crud, Transaction) do |transaction|
      user == transaction.user
    end 

    can(:crud, Offer) do |offer|
      user == offer.user
    end

#     can(:crud, Request) do |request|
#       user == Request.user
#     end

#     can(:post, Request) do |request|
#       user == request.user
#     end
    
    can(:post, Offer) do |offer|
      user == offer.user
    end
  end
end
