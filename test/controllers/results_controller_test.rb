require "test_helper"

class ResultsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @result = results(:one)
  end

  test "should get index" do
    get results_url
    assert_response :success
  end

  test "should get new" do
    get new_result_url
    assert_response :success
  end

  test "should create result" do
    assert_difference('Result.count') do
      post results_url, params: { result: { batch_id: @result.batch_id, credits: @result.credits, external_marks: @result.external_marks, grade: @result.grade, internal_marks: @result.internal_marks, regulation_id: @result.regulation_id, result: @result.result, semester_id: @result.semester_id, subject_id: @result.subject_id, total_marks: @result.total_marks, user_id: @result.user_id } }
    end

    assert_redirected_to result_url(Result.last)
  end

  test "should show result" do
    get result_url(@result)
    assert_response :success
  end

  test "should get edit" do
    get edit_result_url(@result)
    assert_response :success
  end

  test "should update result" do
    patch result_url(@result), params: { result: { batch_id: @result.batch_id, credits: @result.credits, external_marks: @result.external_marks, grade: @result.grade, internal_marks: @result.internal_marks, regulation_id: @result.regulation_id, result: @result.result, semester_id: @result.semester_id, subject_id: @result.subject_id, total_marks: @result.total_marks, user_id: @result.user_id } }
    assert_redirected_to result_url(@result)
  end

  test "should destroy result" do
    assert_difference('Result.count', -1) do
      delete result_url(@result)
    end

    assert_redirected_to results_url
  end
end
