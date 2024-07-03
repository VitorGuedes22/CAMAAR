require 'rails_helper'

RSpec.describe "classes/edit", type: :view do
  before(:each) do
    @class = assign(:class, Class.create!(
      code: "MyString",
      name: "MyString",
      classCode: "MyString",
      semester: "MyString",
      time: "MyString"
    ))
  end

  it "renders the edit class form" do
    render

    assert_select "form[action=?][method=?]", class_path(@class), "post" do

      assert_select "input[name=?]", "class[code]"

      assert_select "input[name=?]", "class[name]"

      assert_select "input[name=?]", "class[classCode]"

      assert_select "input[name=?]", "class[semester]"

      assert_select "input[name=?]", "class[time]"
    end
  end
end
