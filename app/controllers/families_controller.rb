class FamiliesController < ApplicationController
  before_action :set_family, only: [:show, :update]

  swagger_controller :users, "Family Management"

  swagger_api :index do
    summary "Fetches all families"
    notes "This lists all the families"
  end

  swagger_api :show do
    summary "Shows one family"
    param :path, :id, :integer, :required, "Family ID"
    notes "This lists details of one family"
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Family"
    param :form, :family_name, :string, :required, "Family name"
    response :not_acceptable
  end

  swagger_api :update do
    summary "Updates an existing Family"
    param :path, :id, :integer, :required, "Family Id"
    param :form, :family_name, :string, :opitonal, "Family name"
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Family"
    param :path, :id, :integer, :required, "Family Id"
    response :not_found
  end

  # GET /families
  def index
    @families = Family.all

    render json: @families
  end

  # GET /families/1
  def show
    render json: @family
  end

  # POST /families
  def create
    @family = Family.new(family_params)

    if @family.save
      render json: @family, status: :created, location: @family
    else
      render json: @family.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /families/1
  def update
    if @family.update(family_params)
      render json: @family
    else
      render json: @family.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_family
      @family = Family.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def family_params
      params.permit(:family_name, :patient_id)
    end
end
