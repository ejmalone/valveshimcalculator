require "application_system_test_case"

class CylindersTest < ApplicationSystemTestCase
  setup do
    @cylinder = cylinders(:one)
  end

  test "visiting the index" do
    visit cylinders_url
    assert_selector "h1", text: "Cylinders"
  end

  test "should create cylinder" do
    visit cylinders_url
    click_on "New cylinder"

    fill_in "Engine", with: @cylinder.engine_id
    click_on "Create Cylinder"

    assert_text "Cylinder was successfully created"
    click_on "Back"
  end

  test "should update Cylinder" do
    visit cylinder_url(@cylinder)
    click_on "Edit this cylinder", match: :first

    fill_in "Engine", with: @cylinder.engine_id
    click_on "Update Cylinder"

    assert_text "Cylinder was successfully updated"
    click_on "Back"
  end

  test "should destroy Cylinder" do
    visit cylinder_url(@cylinder)
    click_on "Destroy this cylinder", match: :first

    assert_text "Cylinder was successfully destroyed"
  end
end
