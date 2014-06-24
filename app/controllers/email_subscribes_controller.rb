class EmailSubscribesController < ApplicationController
  before_action :set_email_subscribe, only: [:show, :edit, :update, :destroy]

  # GET /email_subscribes
  # GET /email_subscribes.json
  def index
    @email_subscribes = EmailSubscribe.all
  end

  # GET /email_subscribes/1
  # GET /email_subscribes/1.json
  def show
  end

  # GET /email_subscribes/new
  def new
    @email_subscribe = EmailSubscribe.new
  end

  # GET /email_subscribes/1/edit
  def edit
  end

  # POST /email_subscribes
  # POST /email_subscribes.json
  def create
    @email_subscribe = EmailSubscribe.new(email_subscribe_params)

    respond_to do |format|
      if @email_subscribe.save
        format.html { redirect_to @email_subscribe, notice: 'Email subscribe was successfully created.' }
        format.json { render :show, status: :created, location: @email_subscribe }
      else
        format.html { render :new }
        format.json { render json: @email_subscribe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /email_subscribes/1
  # PATCH/PUT /email_subscribes/1.json
  def update
    respond_to do |format|
      if @email_subscribe.update(email_subscribe_params)
        format.html { redirect_to @email_subscribe, notice: 'Email subscribe was successfully updated.' }
        format.json { render :show, status: :ok, location: @email_subscribe }
      else
        format.html { render :edit }
        format.json { render json: @email_subscribe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /email_subscribes/1
  # DELETE /email_subscribes/1.json
  def destroy
    @email_subscribe.destroy
    respond_to do |format|
      format.html { redirect_to email_subscribes_url, notice: 'Email subscribe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email_subscribe
      @email_subscribe = EmailSubscribe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_subscribe_params
      params.require(:email_subscribe).permit(:email)
    end
end
