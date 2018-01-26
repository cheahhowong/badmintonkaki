class CreateUserEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :user_events do |t|
    	t.integer :role, default: 0
    	t.references :user, foreign_key: true
    	t.references :event, foreign_key: true

      	t.timestamps
    end
  end
end
