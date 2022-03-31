require 'application_system_test_case'

class ValveAdjustmentsTest < ApplicationSystemTestCase
  setup do
    @valve_adjustment = valve_adjustments(:one)
  end

  test 'visiting the index' do
    visit valve_adjustments_url
    assert_selector 'h1', text: 'Valve adjustments'
  end

  test 'should create valve adjustment' do
    visit valve_adjustments_url
    click_on 'New valve adjustment'

    fill_in 'Adjustment date', with: @valve_adjustment.adjustment_date
    fill_in 'Engine', with: @valve_adjustment.engine_id
    fill_in 'Mileage', with: @valve_adjustment.mileage
    fill_in 'Notes', with: @valve_adjustment.notes
    click_on 'Create Valve adjustment'

    assert_text 'Valve adjustment was successfully created'
    click_on 'Back'
  end

  test 'should update Valve adjustment' do
    visit valve_adjustment_url(@valve_adjustment)
    click_on 'Edit this valve adjustment', match: :first

    fill_in 'Adjustment date', with: @valve_adjustment.adjustment_date
    fill_in 'Engine', with: @valve_adjustment.engine_id
    fill_in 'Mileage', with: @valve_adjustment.mileage
    fill_in 'Notes', with: @valve_adjustment.notes
    click_on 'Update Valve adjustment'

    assert_text 'Valve adjustment was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Valve adjustment' do
    visit valve_adjustment_url(@valve_adjustment)
    click_on 'Destroy this valve adjustment', match: :first

    assert_text 'Valve adjustment was successfully destroyed'
  end
end
