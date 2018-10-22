require 'test_helper'

class PatientSessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @patient_session = patient_sessions(:one)
  end

  test "should get index" do
    get patient_sessions_url, as: :json
    assert_response :success
  end

  test "should create patient_session" do
    assert_difference('PatientSession.count') do
      post patient_sessions_url, params: { patient_session: { end_time: @patient_session.end_time, patient_id: @patient_session.patient_id, start_time: @patient_session.start_time } }, as: :json
    end

    assert_response 201
  end

  test "should show patient_session" do
    get patient_session_url(@patient_session), as: :json
    assert_response :success
  end

  test "should update patient_session" do
    patch patient_session_url(@patient_session), params: { patient_session: { end_time: @patient_session.end_time, patient_id: @patient_session.patient_id, start_time: @patient_session.start_time } }, as: :json
    assert_response 200
  end

  test "should destroy patient_session" do
    assert_difference('PatientSession.count', -1) do
      delete patient_session_url(@patient_session), as: :json
    end

    assert_response 204
  end
end
