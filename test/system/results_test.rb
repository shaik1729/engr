require "application_system_test_case"

class ResultsTest < ApplicationSystemTestCase
  setup do
    @result = results(:one)
  end

  test "visiting the index" do
    visit results_url
    assert_selector "h1", text: "Results"
  end

  test "creating a Result" do
    visit results_url
    click_on "New Result"

    fill_in "Batch", with: @result.batch_id
    fill_in "Credits", with: @result.credits
    fill_in "External marks", with: @result.external_marks
    fill_in "Grade", with: @result.grade
    fill_in "Internal marks", with: @result.internal_marks
    fill_in "Regulation", with: @result.regulation_id
    fill_in "Result", with: @result.result
    fill_in "Semester", with: @result.semester_id
    fill_in "Subject", with: @result.subject_id
    fill_in "Total marks", with: @result.total_marks
    fill_in "User", with: @result.user_id
    click_on "Create Result"

    assert_text "Result was successfully created"
    click_on "Back"
  end

  test "updating a Result" do
    visit results_url
    click_on "Edit", match: :first

    fill_in "Batch", with: @result.batch_id
    fill_in "Credits", with: @result.credits
    fill_in "External marks", with: @result.external_marks
    fill_in "Grade", with: @result.grade
    fill_in "Internal marks", with: @result.internal_marks
    fill_in "Regulation", with: @result.regulation_id
    fill_in "Result", with: @result.result
    fill_in "Semester", with: @result.semester_id
    fill_in "Subject", with: @result.subject_id
    fill_in "Total marks", with: @result.total_marks
    fill_in "User", with: @result.user_id
    click_on "Update Result"

    assert_text "Result was successfully updated"
    click_on "Back"
  end

  test "destroying a Result" do
    visit results_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Result was successfully destroyed"
  end
end
