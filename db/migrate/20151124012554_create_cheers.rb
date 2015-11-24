class CreateCheers < ActiveRecord::Migration
  def change
    create_table :cheers do |t|
      t.integer :user_id, null: false
      t.integer :goal_id, null: false

      t.timestamps null: false
    end
    add_index :cheers, :user_id
    add_index :cheers, :goal_id
    add_index :cheers, [:user_id, :goal_id], unique: true
  end
end
