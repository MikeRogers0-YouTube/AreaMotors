require 'acceptance/acceptance_helper'

feature 'Enquiries - Search', acceptance: true do
  let!(:enquiry_1) do
    Enquiry.create_from_source(
      source: :a_m_direct,
      source_url: 'amdirect-1.html',
      source_html: File.open('spec/fixtures/amdirect-1.html').read
    )
  end

  let!(:enquiry_2) do
    Enquiry.create_from_source(
      source: :a_m_direct,
      source_url: 'amdirect-2.html',
      source_html: File.open('spec/fixtures/amdirect-2.html').read
    )
  end

  let!(:enquiry_3) do
    Enquiry.create_from_source(
      source: :cars_for_sale,
      source_url: 'carsforsale-1.html',
      source_html: File.open('spec/fixtures/carsforsale-1.html').read
    )
  end

  before do
    enquiry_1.email = 'a-very-unique-email@example.com'
    enquiry_1.name = 'Mrs Unique Name'
    enquiry_1.save
  end

  scenario 'User can search for an enquiry customer by their email' do
    expect(Enquiry.count).to eq(3)

    visit enquiries_path

    expect(page).to have_selector('table.enquiries tbody tr', count: 3)

    within '.enquiry_search' do
      fill_in :query, with: enquiry_1.email.split('@').first
      click_on 'Search'
    end

    expect(page).to have_selector('table.enquiries tbody tr', count: 1)
    expect(find(:css, 'table.enquiries')).to have_text(enquiry_1.email)
  end

  scenario 'User can search for an enquiry customer by their name' do
    expect(Enquiry.count).to eq(3)

    visit enquiries_path

    expect(page).to have_selector('table.enquiries tbody tr', count: 3)

    within '.enquiry_search' do
      fill_in :query, with: enquiry_1.name
      click_on 'Search'
    end

    expect(page).to have_selector('table.enquiries tbody tr', count: 1)
    expect(find(:css, 'table.enquiries')).to have_text(enquiry_1.name)
  end
end
