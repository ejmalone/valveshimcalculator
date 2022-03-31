# frozen_string_literal: true

require 'test_helper'

class ValveAdjustmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @engine = create(:klr650)
    sign_in @engine.user
    @valve_adjustment = build(:valve_adjustment)
    @valve_adjustment.engine = @engine
    @valve_adjustment.save
  end

  test 'should get index' do
    get engine_valve_adjustments_url(@engine)
    assert_response :success
  end

  test 'should get new' do
    get new_engine_valve_adjustment_url(@engine)
    assert_response :success
  end

  test 'should create valve_adjustment' do
    assert_difference('ValveAdjustment.count') do
      post engine_valve_adjustments_url(@engine),
           params: { valve_adjustment: { adjustment_date: @valve_adjustment.adjustment_date, mileage: @valve_adjustment.mileage,
                                         notes: @valve_adjustment.notes } }
    end

    assert_redirected_to engine_valve_adjustment_url(@engine, ValveAdjustment.last)
  end

  test 'should show valve_adjustment' do
    get engine_valve_adjustment_url(@engine, @valve_adjustment)
    assert_response :success
  end

  test 'should get edit' do
    get edit_engine_valve_adjustment_url(@engine, @valve_adjustment)
    assert_response :success
  end

  test 'should update valve_adjustment' do
    patch engine_valve_adjustment_url(@engine, @valve_adjustment),
          params: { valve_adjustment: { adjustment_date: @valve_adjustment.adjustment_date,
                                        engine_id: @valve_adjustment.engine_id, mileage: @valve_adjustment.mileage, notes: @valve_adjustment.notes } }
    assert_redirected_to engine_valve_adjustment_url(@engine, @valve_adjustment)
  end

  test 'should destroy valve_adjustment' do
    assert_difference('ValveAdjustment.count', -1) do
      delete engine_valve_adjustment_url(@engine, @valve_adjustment)
    end

    assert_redirected_to engine_valve_adjustments_url(@engine)
  end
end
