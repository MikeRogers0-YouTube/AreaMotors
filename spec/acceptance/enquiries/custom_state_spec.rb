require 'acceptance/acceptance_helper'

feature 'Enquiries - Custom states', acceptance: true do
  let!(:enquiry) do
    Enquiry.create_from_source(
      source: :a_m_direct,
      source_html: File.open('spec/fixtures/amdirect-1.html').read
    )
  end

  scenario 'User can set a custom state for an enquiry' do
    expect(enquiry.state_custom?).to eq(false)

    visit enquiry_path(enquiry)

    within '.actions' do
      click_on 'Edit'
    end

    within '.edit_enquiry' do
      select 'Custom', from: :enquiry_state
      fill_in :enquiry_custom_state, with: 'Follow up'
      fill_in :enquiry_notes, with: 'Customer needs a callback in a week.'
      click_on 'Update Enquiry'
    end

    within '.alerts' do
      expect(page).to have_content 'Enquiry updated'
    end

    enquiry.reload
    expect(enquiry.state_custom?).to eq(true)
    expect(enquiry.custom_state).to eq('Follow up')
    expect(enquiry.notes).to eq('Customer needs a callback in a week.')

    expect(current_path).to eq(enquiry_path(enquiry))
    expect(page).to have_content 'State Follow up'
  end
end
