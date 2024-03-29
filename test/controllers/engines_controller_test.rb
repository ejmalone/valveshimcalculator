# frozen_string_literal: true

require 'test_helper'

class EnginesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    sign_in @user
    @engine = build(:klr650, userable: @user)
  end

  test 'should get index' do
    get engines_url
    assert_response :success
  end

  test 'should get new' do
    get new_engine_url
    assert_response :success
  end

  test 'should create engine' do
    assert_difference('Engine.count') do
      post engines_url,
           params: { engine: { num_cylinders: @engine.num_cylinders, exhaust_max: @engine.exhaust_max,
                               exhaust_min: @engine.exhaust_min, intake_max: @engine.intake_max,
                               intake_min: @engine.intake_min, make: @engine.make, model: @engine.model,
                               valves_per_cylinder: @engine.valves_per_cylinder } }
    end

    @engine = Engine.where(userable: @engine.userable, make: @engine.make, model: @engine.model).last
    assert_redirected_to edit_all_engine_shims_url(@engine)
  end

  #   test "should show engine" do
  #     get engine_url(@engine)
  #     assert_response :success
  #   end
  #
  #   test "should get edit" do
  #     get edit_engine_url(@engine)
  #     assert_response :success
  #   end
  #
  #   test "should update engine" do
  #     patch engine_url(@engine), params: { engine: { num_cylinders: @engine.num_cylinders, exhaust_max: @engine.exhaust_max, exhaust_min: @engine.exhaust_min, intake_max: @engine.intake_max, intake_min: @engine.intake_min, name: @engine.name, valves_per_cylinder: @engine.valves_per_cylinder } }
  #     assert_redirected_to engine_url(@engine)
  #   end
  #
  #   test "should destroy engine" do
  #     assert_difference("Engine.count", -1) do
  #       delete engine_url(@engine)
  #     end
  #
  #     assert_redirected_to engines_url
  #   end
end
