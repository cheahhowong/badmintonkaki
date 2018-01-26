class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
    	t.string :title
    	t.string :description
    	t.date :start_date
    	t.time :start_time
    	t.time :end_time
    	t.string :address
    	t.string :state
    	t.string :city
    	t.string :postcode
        t.float :latitude
        t.float :longitude
        t.references :user_event, foreign_key: true

      	t.timestamps
    end
  end
end
