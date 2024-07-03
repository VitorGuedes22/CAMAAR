require 'rails_helper'

RSpec.describe "classes/show", type: :view do
  before(:each) do
    @class = assign(:class, Class.create!(
      code: "Code",
      name: "Name",
      classCode: "Class Code",
      semester: "Semester",
      time: "Time"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Code/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Class Code/)
    expect(rendered).to match(/Semester/)
    expect(rendered).to match(/Time/)
  end
end
