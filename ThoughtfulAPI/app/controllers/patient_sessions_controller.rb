class PatientSessionsController < ApplicationController
  before_action :set_patient_session, only: [:show]

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
      params.require(:patient_session).permit(:patient_id, :start_time, :end_time)
    end
end
