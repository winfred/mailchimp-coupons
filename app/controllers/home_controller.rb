class HomeController < ApplicationController
  def index
    redirect_to action: :show if logged_in?
  end

  def show
    redirect_to action: :index and return unless logged_in?
    redirect_to controller: :coupons, action: :index
  end
end
