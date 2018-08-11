class RemoveSourceUrlFromEnquiries < ActiveRecord::Migration[5.2]
  def change
    remove_column :enquiries, :source_url, :string
  end
end
