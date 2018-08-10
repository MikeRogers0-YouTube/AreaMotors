require 'rails_helper'

RSpec.describe EnquiryParser::CarsForSale do
  let(:source_html){ File.open('spec/fixtures/carsforsale-1.html').read }
  let(:enquiry) { EnquiryParser::CarsForSale.new(source_html) }

  describe '.attributes' do
    it 'returns hash for populating Enquiry model' do
      expect(enquiry.attributes).to eq({
        'name': 'John Smith',
        'email': 'johnsmith@mailinator.com',
        'message': "Do you take part exchange?<br>What is the warranty like?",
        'listing_make': 'Renault',
        'listing_model': 'Clio',
        'listing_year': '2006',
        'listing_colour': 'White',
        'listing_url': '/carsforsale-1-listing.html',
        'listing_reference': nil
      })
    end
  end

  describe '.name' do
    it { expect(enquiry.name).to eq('John Smith') }
  end

  describe '.email' do
    it { expect(enquiry.email).to eq('johnsmith@mailinator.com') }
  end

  describe '.message' do
    it { expect(enquiry.message).to eq("Do you take part exchange?<br>What is the warranty like?") }
  end

  describe '.listing_make' do
    it { expect(enquiry.listing_make).to eq('Renault') }
  end

  describe '.listing_model' do
    it { expect(enquiry.listing_model).to eq('Clio') }
  end

  describe '.listing_year' do
    it { expect(enquiry.listing_year).to eq('2006') }
  end

  describe '.listing_colour' do
    it { expect(enquiry.listing_colour).to eq('White') }
  end

  describe '.listing_url' do
    it { expect(enquiry.listing_url).to eq('/carsforsale-1-listing.html') }
  end
end

