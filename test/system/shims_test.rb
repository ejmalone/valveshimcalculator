require 'application_system_test_case'

class ShimsTest < ApplicationSystemTestCase
  setup do
    @shim = shims(:one)
  end

  test 'visiting the index' do
    visit shims_url
    assert_selector 'h1', text: 'Shims'
  end

  test 'should create shim' do
    visit shims_url
    click_on 'New shim'

    fill_in 'Cylinder', with: @shim.cylinder
    fill_in 'Engine', with: @shim.engine_id
    check 'In use' if @shim.in_use
    fill_in 'Size mm', with: @shim.size_mm
    fill_in 'Valve', with: @shim.valve
    fill_in 'Valve num', with: @shim.valve_num
    click_on 'Create Shim'

    assert_text 'Shim was successfully created'
    click_on 'Back'
  end

  test 'should update Shim' do
    visit shim_url(@shim)
    click_on 'Edit this shim', match: :first

    fill_in 'Cylinder', with: @shim.cylinder
    fill_in 'Engine', with: @shim.engine_id
    check 'In use' if @shim.in_use
    fill_in 'Size mm', with: @shim.size_mm
    fill_in 'Valve', with: @shim.valve
    fill_in 'Valve num', with: @shim.valve_num
    click_on 'Update Shim'

    assert_text 'Shim was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Shim' do
    visit shim_url(@shim)
    click_on 'Destroy this shim', match: :first

    assert_text 'Shim was successfully destroyed'
  end
end
