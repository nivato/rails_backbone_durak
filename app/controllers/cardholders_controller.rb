class CardholdersController < ApplicationController
  # GET /cardholders
  # GET /cardholders.json
  def index
    @cardholders = Cardholder.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cardholders }
    end
  end

  # GET /cardholders/1
  # GET /cardholders/1.json
  def show
    @cardholder = Cardholder.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cardholder }
    end
  end

  # GET /cardholders/new
  # GET /cardholders/new.json
  def new
    @cardholder = Cardholder.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cardholder }
    end
  end

  # GET /cardholders/1/edit
  def edit
    @cardholder = Cardholder.find(params[:id])
  end

  # POST /cardholders
  # POST /cardholders.json
  def create
    @cardholder = Cardholder.new(params[:cardholder])

    respond_to do |format|
      if @cardholder.save
        format.html { redirect_to @cardholder, notice: 'Cardholder was successfully created.' }
        format.json { render json: @cardholder, status: :created, location: @cardholder }
      else
        format.html { render action: "new" }
        format.json { render json: @cardholder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cardholders/1
  # PUT /cardholders/1.json
  def update
    @cardholder = Cardholder.find(params[:id])

    respond_to do |format|
      if @cardholder.update_attributes(params[:cardholder])
        format.html { redirect_to @cardholder, notice: 'Cardholder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cardholder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cardholders/1
  # DELETE /cardholders/1.json
  def destroy
    @cardholder = Cardholder.find(params[:id])
    @cardholder.destroy

    respond_to do |format|
      format.html { redirect_to cardholders_url }
      format.json { head :no_content }
    end
  end
end
