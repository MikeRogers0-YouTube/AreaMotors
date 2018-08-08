class CreateEnquiries < ActiveRecord::Migration[5.2]
  def change
    create_table :enquiries do |t|
      t.string :name
      t.string :email
      t.text :message
      t.integer :source
      t.string :listing_make
      t.string :listing_model
      t.string :listing_year
      t.string :listing_colour
      t.string :listing_url
      t.string :listing_reference

      t.timestamps
    end
  end
end
