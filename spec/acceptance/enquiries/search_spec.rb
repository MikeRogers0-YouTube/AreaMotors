require 'acceptance/acceptance_helper'

feature 'Enquiries - Search', acceptance: true do
  let!(:enquiry_1){ Enquiry.create!(email: 'customer_1@example.com') }
  let!(:enquiry_2){ Enquiry.create!(email: 'customer_2@example.com') }

  scenario 'User can search for an enquiry by a specifc user' do
    expect(Enquiry.count).to eq(1)

    visit enquries_path

    expect(page).to have_selector(".customer-enquiry", count: 2)

    within '.search-form' do
      fill_in :search, with: enquiry_1.split('@').first
      submit
    end

    expect(page).to have_selector(".customer-enquiry", count: 2)
    expect(find(:css, '.customer-enquiry .customer-enquiry__email')).to have_text(enquiry_1.email)
  end
end
