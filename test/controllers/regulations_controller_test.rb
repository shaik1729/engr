require "test_helper"

class RegulationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @regulation = regulations(:one)
  end

  test "should get index" do
    get regulations_url
    assert_response :success
  end

  test "should get new" do
    get new_regulation_url
    assert_response :success
  end

  test "should create regulation" do
    assert_difference('Regulation.count') do
      post regulations_url, params: { regulation: { code: @regulation.code, name: @regulation.name, user_id: @regulation.user_id } }
    end

    assert_redirected_to regulation_url(Regulation.last)
  end

  test "should show regulation" do
    get regulation_url(@regulation)
    assert_response :success
  end

  test "should get edit" do
    get edit_regulation_url(@regulation)
    assert_response :success
  end

  test "should update regulation" do
    patch regulation_url(@regulation), params: { regulation: { code: @regulation.code, name: @regulation.name, user_id: @regulation.user_id } }
    assert_redirected_to regulation_url(@regulation)
  end

  test "should destroy regulation" do
    assert_difference('Regulation.count', -1) do
      delete regulation_url(@regulation)
    end

    assert_redirected_to regulations_url
  end
end
