class CreateMemberships < ActiveRecord::Migration[7.1]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :course_class, null: false, foreign_key: true
      t.string :role, null: false  # 'docente' or 'dicente'

      t.timestamps
    end
  end
end
