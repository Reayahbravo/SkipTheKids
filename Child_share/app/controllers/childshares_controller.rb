class ChildsharesController < ApplicationController
    def dashboard
        @offers = Offer.where('proposed_from > ?', DateTime.now).order(proposed_from: :asc)
        @requests = Request.where('proposed_from > ?', DateTime.now).order(proposed_from: :asc)

    end
end
