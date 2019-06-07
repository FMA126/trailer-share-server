# frozen_string_literal: true

<<<<<<< HEAD
class TrailersController < ApplicationController
  before_action :set_trailer, only: %i[show update destroy]
=======
class TrailersController < OpenReadController
  before_action :set_trailer, only: %i[update destroy]
>>>>>>> dev

  # GET /trailers
  def index
    @trailers = Trailer.all

    render json: @trailers
  end

  # GET /trailers/1
  def show
<<<<<<< HEAD
    render json: @trailer
=======
    render json: Trailer.find(params[:id])
>>>>>>> dev
  end

  # POST /trailers
  def create
<<<<<<< HEAD
    @trailer = Trailer.new(trailer_params)
=======
    @trailer = current_user.trailers.build(trailer_params)
>>>>>>> dev

    if @trailer.save
      render json: @trailer, status: :created, location: @trailer
    else
      render json: @trailer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /trailers/1
  def update
    if @trailer.update(trailer_params)
      render json: @trailer
    else
      render json: @trailer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /trailers/1
  def destroy
    @trailer.destroy
<<<<<<< HEAD
=======

    head :no_content
>>>>>>> dev
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_trailer
    @trailer = Trailer.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def trailer_params
    params.require(:trailer).permit(:user_id, :make, :model, :year, :trailer_type, :hitch_type, :length, :gvwr)
  end
end
