class AmandmentsController < ApplicationController
  before_action :set_amandment, only: [:show, :edit, :update, :destroy]

  # GET /amandments
  def index
    @amandments = Amandment.all
  end

  # GET /amandments/1
  def show
  end

  # GET /amandments/new
  def new
    @amandment = Amandment.new
  end

  # GET /amandments/1/edit
  def edit
  end

  # POST /amandments
  def create
    @amandment = Amandment.new(amandment_params)

    if @amandment.save
      redirect_to @amandment, notice: 'Amandment was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /amandments/1
  def update
    if @amandment.update(amandment_params)
      redirect_to @amandment, notice: 'Amandment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /amandments/1
  def destroy
    @amandment.destroy
    redirect_to amandments_url, notice: 'Amandment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_amandment
      @amandment = Amandment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def amandment_params
      params[:amandment]
    end
end
