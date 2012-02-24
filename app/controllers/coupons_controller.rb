class CouponsController < ApplicationController
  before_filter :logged_in?
  # GET /coupons
  # GET /coupons.json
  def index
    redirect_to controller: :home, action: :index unless logged_in?
    @coupons = current_user.coupons
    @lists = current_user.api.lists['data']
    logger.info @lists.inspect
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @coupons }
    end
  end

  # GET /coupons/1
  # GET /coupons/1.json
  def show
    @coupon = current_user.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @coupon }
    end
  end

  # GET /coupons/new
  # GET /coupons/new.json
  def new
    @coupon = current_user.coupons.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @coupon }
    end
  end

  # GET /coupons/1/edit
  def edit
    @coupon = current_user.coupons.find(params[:id])
  end

  # POST /coupons
  # POST /coupons.json
  def create
    @coupon = current_user.coupons.create(params[:coupon])

    respond_to do |format|
      if @coupon.save
        format.html { redirect_to @coupon, notice: 'Coupon was successfully created.' }
        format.json { render json: @coupon, status: :created, location: @coupon }
      else
        format.html { render action: "new" }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /coupons/1
  # PUT /coupons/1.json
  def update
    @coupon = current_user.coupons.find(params[:id])

    respond_to do |format|
      if @coupon.update_attributes(params[:coupon])
        format.html { redirect_to @coupon, notice: 'Coupon was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    @coupon = current_user.coupons.find(params[:id])
    @coupon.destroy

    respond_to do |format|
      format.html { redirect_to coupons_url }
      format.json { head :no_content }
    end
  end
  
  # POST /coupons/1/consume
  def consume
    @coupon = current_user.coupons.find(params[:id])
    render json: @coupon.consume(params[:email])
  end

  def subscribe
    res = current_user.api.listSubscribe(id: params[:list_id],email_address: params[:email],
                                                merge_vars: {"OPTIN-IP" => request.remote_ip, "OPTIN-TIME" => Time.now})
    render json:  res
  end

  def send_to_consumed
    @coupon = current_user.coupons.find(params[:id])
    render json: {result: @coupon.create_consumed_campaign}
  end
  
  def send_to_unconsumed
    @coupon = current_user.coupons.find(params[:id])
    render json: {result: @coupon.create_unconsumed_campaign}
  end
end
