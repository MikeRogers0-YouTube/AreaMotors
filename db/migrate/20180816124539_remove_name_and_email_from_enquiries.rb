class RemoveNameAndEmailFromEnquiries < ActiveRecord::Migration[5.2]
  def change
    remove_column :enquiries, :name, :string
    remove_column :enquiries, :email, :string
  end
end
