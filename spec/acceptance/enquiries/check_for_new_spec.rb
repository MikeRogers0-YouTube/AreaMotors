require 'acceptance/acceptance_helper'

feature 'Enquiries - check for new', acceptance: true do
  scenario 'User can check for new enquries and the database populates' do
    expect(Enquiry.count).to eq(0)

    visit enquiries_path

    within '.actions' do
      click_on 'Check for new enquiries'
    end

    within '.alerts' do
      expect(page).to have_content 'Found 3 new enquiries'
    end

    expect(Enquiry.count).to eq(3)
  end
end
