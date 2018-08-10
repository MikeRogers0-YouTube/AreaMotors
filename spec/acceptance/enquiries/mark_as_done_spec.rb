require 'acceptance/acceptance_helper'

feature 'Enquiries - mark as done', acceptance: true do
  let!(:enquiry){ Enquiry.create!() }

  scenario 'User can mark a enquiry as done' do
    expect(enquiry.done?).to eq(false)

    visit enquiry_path(enquiry)

    within '.actions' do
      click_on 'Mark as done'
    end

    within '.alerts' do
      expect(page).to have_content 'Enquiry marked as done'
    end

    enquiry.reload
    expect(enquiry.done?).to eq(true)
  end
end
