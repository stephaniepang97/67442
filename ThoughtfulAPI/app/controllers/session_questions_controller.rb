class SessionQuestionsController < ApplicationController
  before_action :set_session_question, only: [:show]

  swagger_controller :users, "Session Question Management"

  swagger_api :index do
    summary "Fetches all Session Questions"
    notes "This lists all the session questions"
  end

  swagger_api :show do
    summary "Shows one Session Question"
    param :path, :id, :integer, :required, "Session Question ID"
    notes "This lists details of one Session Question"
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Session Question"
    param :form, :patient_sessions_id, :integer, :required, "Patient Session ID"
    param :form, :questions_id, :integer, :required, "Question ID"
    param :form, :correct, :boolean, :required, "Correct"
    response :not_acceptable
  end


  # GET /session_questions
  def index
    @session_questions = SessionQuestion.all

    render json: @session_questions
  end

  # GET /session_questions/1
  def show
    render json: @session_question
  end

  # POST /session_questions
  def create
    @session_question = SessionQuestion.new(session_question_params)

    if @session_question.save
      render json: @session_question, status: :created, location: @session_question
    else
      render json: @session_question.errors, status: :unprocessable_entity
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session_question
      @session_question = SessionQuestion.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def session_question_params
      params.permit(:patient_sessions_id, :questions_id, :correct)
    end
end
