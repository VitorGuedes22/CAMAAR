require 'rails_helper'

RSpec.describe "classes/new", type: :view do
  before(:each) do
    assign(:class, Class.new(
      code: "MyString",
      name: "MyString",
      classCode: "MyString",
      semester: "MyString",
      time: "MyString"
    ))
  end

  it "renders new class form" do
    render

    assert_select "form[action=?][method=?]", classes_path, "post" do

      assert_select "input[name=?]", "class[code]"

      assert_select "input[name=?]", "class[name]"

      assert_select "input[name=?]", "class[classCode]"

      assert_select "input[name=?]", "class[semester]"

      assert_select "input[name=?]", "class[time]"
    end
  end
end
