require "test_helper"

class EnginesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @engine = engines(:one)
  end

  test "should get index" do
    get engines_url
    assert_response :success
  end

  test "should get new" do
    get new_engine_url
    assert_response :success
  end

  test "should create engine" do
    assert_difference("Engine.count") do
      post engines_url, params: { engine: { cylinders: @engine.cylinders, name: @engine.name, user_id: @engine.user_id, valves_per_cylinder: @engine.valves_per_cylinder } }
    end

    assert_redirected_to engine_url(Engine.last)
  end

  test "should show engine" do
    get engine_url(@engine)
    assert_response :success
  end

  test "should get edit" do
    get edit_engine_url(@engine)
    assert_response :success
  end

  test "should update engine" do
    patch engine_url(@engine), params: { engine: { cylinders: @engine.cylinders, name: @engine.name, user_id: @engine.user_id, valves_per_cylinder: @engine.valves_per_cylinder } }
    assert_redirected_to engine_url(@engine)
  end

  test "should destroy engine" do
    assert_difference("Engine.count", -1) do
      delete engine_url(@engine)
    end

    assert_redirected_to engines_url
  end
end
