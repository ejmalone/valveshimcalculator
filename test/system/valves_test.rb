require 'application_system_test_case'

class ValvesTest < ApplicationSystemTestCase
  setup do
    @valve = valves(:one)
  end

  test 'visiting the index' do
    visit valves_url
    assert_selector 'h1', text: 'Valves'
  end

  test 'should create valve' do
    visit valves_url
    click_on 'New valve'

    fill_in 'Cylinder', with: @valve.cylinder_id
    fill_in 'Gap', with: @valve.gap
    click_on 'Create Valve'

    assert_text 'Valve was successfully created'
    click_on 'Back'
  end

  test 'should update Valve' do
    visit valve_url(@valve)
    click_on 'Edit this valve', match: :first

    fill_in 'Cylinder', with: @valve.cylinder_id
    fill_in 'Gap', with: @valve.gap
    click_on 'Update Valve'

    assert_text 'Valve was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Valve' do
    visit valve_url(@valve)
    click_on 'Destroy this valve', match: :first

    assert_text 'Valve was successfully destroyed'
  end
end
