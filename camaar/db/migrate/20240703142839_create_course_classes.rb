class CreateCourseClasses < ActiveRecord::Migration[7.1]
  def change
    create_table :course_classes do |t|
      t.string :code
      t.string :name
      t.string :classCode
      t.string :semester
      t.string :time

      t.timestamps
    end
  end
end
