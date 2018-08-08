class AddStatesToEnquiries < ActiveRecord::Migration[5.2]
  def change
    add_column :enquiries, :state, :integer, default: 10
  end
end
