class AssignPreviousEnquiresToCustomers < ActiveRecord::Migration[5.2]
  def up
    add_reference :enquiries, :customer

    Enquiry.reset_column_information
    Enquiry.find_each do |enquiry|
      enquiry.customer = Customer.find_or_create_by(email: enquiry.email, name: enquiry.name)
      enquiry.save
    end
  end

  def down
    remove_reference :enquiries, :customer
  end
end
