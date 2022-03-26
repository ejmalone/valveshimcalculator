require "test_helper"

class ShimsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @shim = shims(:one)
  end

  test "should get index" do
    get shims_url
    assert_response :success
  end

  test "should get new" do
    get new_shim_url
    assert_response :success
  end

  test "should create shim" do
    assert_difference("Shim.count") do
      post shims_url, params: { shim: { cylinder: @shim.cylinder, engine_id: @shim.engine_id, in_use: @shim.in_use, size_mm: @shim.size_mm, valve: @shim.valve, valve_num: @shim.valve_num } }
    end

    assert_redirected_to shim_url(Shim.last)
  end

  test "should show shim" do
    get shim_url(@shim)
    assert_response :success
  end

  test "should get edit" do
    get edit_shim_url(@shim)
    assert_response :success
  end

  test "should update shim" do
    patch shim_url(@shim), params: { shim: { cylinder: @shim.cylinder, engine_id: @shim.engine_id, in_use: @shim.in_use, size_mm: @shim.size_mm, valve: @shim.valve, valve_num: @shim.valve_num } }
    assert_redirected_to shim_url(@shim)
  end

  test "should destroy shim" do
    assert_difference("Shim.count", -1) do
      delete shim_url(@shim)
    end

    assert_redirected_to shims_url
  end
end
