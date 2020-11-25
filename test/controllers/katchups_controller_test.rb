require 'test_helper'

class KatchupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @katchup = katchups(:one)
  end

  test "should get index" do
    get katchups_url, as: :json
    assert_response :success
  end

  test "should create katchup" do
    assert_difference('Katchup.count') do
      post katchups_url, params: { katchup: { relationsship: @katchup.relationsship, restaurant_id: @katchup.restaurant_id, starts_at: @katchup.starts_at } }, as: :json
    end

    assert_response 201
  end

  test "should show katchup" do
    get katchup_url(@katchup), as: :json
    assert_response :success
  end

  test "should update katchup" do
    patch katchup_url(@katchup), params: { katchup: { relationsship: @katchup.relationsship, restaurant_id: @katchup.restaurant_id, starts_at: @katchup.starts_at } }, as: :json
    assert_response 200
  end

  test "should destroy katchup" do
    assert_difference('Katchup.count', -1) do
      delete katchup_url(@katchup), as: :json
    end

    assert_response 204
  end
end
