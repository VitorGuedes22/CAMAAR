require 'rails_helper'

RSpec.describe "classes/index", type: :view do
  before(:each) do
    assign(:classes, [
      Class.create!(
        code: "Code",
        name: "Name",
        classCode: "Class Code",
        semester: "Semester",
        time: "Time"
      ),
      Class.create!(
        code: "Code",
        name: "Name",
        classCode: "Class Code",
        semester: "Semester",
        time: "Time"
      )
    ])
  end

  it "renders a list of classes" do
    render
    assert_select "tr>td", text: "Code".to_s, count: 2
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Class Code".to_s, count: 2
    assert_select "tr>td", text: "Semester".to_s, count: 2
    assert_select "tr>td", text: "Time".to_s, count: 2
  end
end
