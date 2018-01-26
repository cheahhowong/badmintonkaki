class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
    	t.string :title
    	t.string :description
    	t.date :start_date
    	t.datetime :start_time
    	t.datetime :end_time
    	t.string :address
    	t.string :state
    	t.string :city
    	t.string :postcode
        t.float :latitude
        t.float :longitude

      	t.timestamps
    end
  end
end
