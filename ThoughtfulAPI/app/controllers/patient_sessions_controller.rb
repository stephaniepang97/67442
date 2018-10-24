class PatientSessionsController < ApplicationController
  before_action :set_patient_session, only: [:show]

  swagger_controller :users, "Patient Session Management"

  swagger_api :index do
    summary "Fetches all Patient Sessions"
    notes "This lists all the patient sessions"
  end

  swagger_api :show do
    summary "Shows one patient session"
    param :path, :id, :integer, :required, "Patient Session ID"
    notes "This lists details of one patient session"
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Patient Session"
    param :form, :patient_id, :integer, :required, "Patient ID"
    param :form, :start_time, :datetime, :required, "Start Time"
    param :form, :end_time, :datetime, :optional, "End Time"
    response :not_acceptable
  end


  # GET /patient_sessions
  def index
    @patient_sessions = PatientSession.all

    render json: @patient_sessions
  end

  # GET /patient_sessions/1
  def show
    render json: @patient_session
  end

  # POST /patient_sessions
  def create
    @patient_session = PatientSession.new(patient_session_params)

    if @patient_session.save
      render json: @patient_session, status: :created, location: @patient_session
    else
      render json: @patient_session.errors, status: :unprocessable_entity
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient_session
      @patient_session = PatientSession.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def patient_session_params
      params.permit(:patient_id, :start_time, :end_time)
    end
end
