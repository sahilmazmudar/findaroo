class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, unique: true
      t.decimal :budget
      t.integer :lease_duration
      t.boolean :smoking
      t.boolean :drinking
      t.integer :cleanliness
      t.integer :quietness

      t.timestamps
    end
  end
end
