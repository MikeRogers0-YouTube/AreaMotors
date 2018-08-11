class AddCustomStateAndNotesToEnquiries < ActiveRecord::Migration[5.2]
  def change
    add_column :enquiries, :custom_state, :string
    add_column :enquiries, :notes, :text
  end
end
