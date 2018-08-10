require 'acceptance/acceptance_helper'

feature 'Enquiries - Mark as done', acceptance: true do
  let!(:enquiry) do
    Enquiry.create_from_source(
      source: :a_m_direct,
      source_url: 'amdirect-1.html',
      source_html: File.open('spec/fixtures/amdirect-1.html').read
    )
  end

  scenario 'User can mark a enquiry as done' do
    expect(enquiry.state_done?).to eq(false)

    visit enquiry_path(enquiry)

    within '.actions' do
      click_on 'Mark as done'
    end

    within '.alerts' do
      expect(page).to have_content 'Enquiry marked as done'
    end

    enquiry.reload
    expect(enquiry.state_done?).to eq(true)

    expect(current_path).to eq(enquiry_path(enquiry))
    within '.actions' do
      expect(page).to_not have_content 'Mark as done'
    end
  end
end
