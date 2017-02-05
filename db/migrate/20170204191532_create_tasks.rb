class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.belongs_to :category, index: true
      t.string :description
      t.datetime :start
      t.datetime :finish

      t.timestamps
    end
  end
end
