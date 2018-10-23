class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :update, :destroy]

  swagger_controller :users, "Question Management"

  swagger_api :index do
    summary "Fetches all questions"
    notes "This lists all the questions"
  end

  swagger_api :show do
    summary "Shows one question"
    param :path, :id, :integer, :required, "Question ID"
    notes "This lists details of one question"
    response :not_found
  end

  swagger_api :create do
    summary "Creates a new Question"
    param :form, :question, :string, :required, "Question"
    param :form, :answer, :string, :required, "Answer"
    param :form, :attachment, :string, :optional, "Attachment (Base 64)"
    param :form, :created_by, :integer, :required, "Created By (User ID)"
    response :not_acceptable
  end

  swagger_api :update do
    summary "Updates an existing Question"
    param :path, :id, :integer, :required, "Question ID"
    param :form, :question, :string, :optional, "Question"
    param :form, :answer, :string, :optional, "Answer"
    param :form, :attachment, :string, :optional, "Attachment (Base 64)"
    param :form, :created_by, :integer, :optional, "Created By (User ID)"
    response :not_found
    response :not_acceptable
  end

  swagger_api :destroy do
    summary "Deletes an existing Question"
    param :path, :id, :integer, :required, "Question Id"
    response :not_found
  end

  # GET /questions
  def index
    @questions = Question.all

    render json: @questions
  end

  # GET /questions/1
  def show
    render json: @question
  end

  # POST /questions
  def create
    @question = Question.new(question_params)

    if @question.save
      render json: @question, status: :created, location: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      render json: @question
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def question_params
      params.permit(:question, :answer, :created_by, :attachment)
    end
end
