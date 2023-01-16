require "application_system_test_case"

class RegulationsTest < ApplicationSystemTestCase
  setup do
    @regulation = regulations(:one)
  end

  test "visiting the index" do
    visit regulations_url
    assert_selector "h1", text: "Regulations"
  end

  test "creating a Regulation" do
    visit regulations_url
    click_on "New Regulation"

    fill_in "Code", with: @regulation.code
    fill_in "Name", with: @regulation.name
    fill_in "User", with: @regulation.user_id
    click_on "Create Regulation"

    assert_text "Regulation was successfully created"
    click_on "Back"
  end

  test "updating a Regulation" do
    visit regulations_url
    click_on "Edit", match: :first

    fill_in "Code", with: @regulation.code
    fill_in "Name", with: @regulation.name
    fill_in "User", with: @regulation.user_id
    click_on "Update Regulation"

    assert_text "Regulation was successfully updated"
    click_on "Back"
  end

  test "destroying a Regulation" do
    visit regulations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Regulation was successfully destroyed"
  end
end
