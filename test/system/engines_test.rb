require "application_system_test_case"

class EnginesTest < ApplicationSystemTestCase
  setup do
    @engine = engines(:one)
  end

  test "visiting the index" do
    visit engines_url
    assert_selector "h1", text: "Engines"
  end

  test "should create engine" do
    visit engines_url
    click_on "New engine"

    fill_in "Cylinders", with: @engine.cylinders
    fill_in "Name", with: @engine.name
    fill_in "User", with: @engine.user_id
    fill_in "Valves per cylinder", with: @engine.valves_per_cylinder
    click_on "Create Engine"

    assert_text "Engine was successfully created"
    click_on "Back"
  end

  test "should update Engine" do
    visit engine_url(@engine)
    click_on "Edit this engine", match: :first

    fill_in "Cylinders", with: @engine.cylinders
    fill_in "Name", with: @engine.name
    fill_in "User", with: @engine.user_id
    fill_in "Valves per cylinder", with: @engine.valves_per_cylinder
    click_on "Update Engine"

    assert_text "Engine was successfully updated"
    click_on "Back"
  end

  test "should destroy Engine" do
    visit engine_url(@engine)
    click_on "Destroy this engine", match: :first

    assert_text "Engine was successfully destroyed"
  end
end
