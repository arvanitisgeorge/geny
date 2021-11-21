class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :summary
      t.string :description
      t.float :initial_value
      t.float :final_value

      t.timestamps
    end
  end
end
