require 'rails_helper'

RSpec.describe EnquiryParser::AMDirect do

  let(:source_html){ File.open('spec/fixtures/amdirect-1.html').read }
  let(:enquiry) { EnquiryParser::AMDirect.new(source_html) }

  describe '.attributes' do
    it 'returns hash for populating Enquiry model' do
      expect(enquiry.attributes).to eq({
        'name': 'John Smith',
        'email': 'johnsmith@mailinator.com',
        'message': "I'm interested in buying this car.<br>Would you take part exchange?<br>Thanks,<br><br>John",
        'listing_make': 'Ford',
        'listing_model': 'Focus',
        'listing_year': '2008',
        'listing_colour': 'blue',
        'listing_url': '/amdirect-1-listing.html',
        'listing_reference': 'AMD-FF1'
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
    it { expect(enquiry.message).to eq("I'm interested in buying this car.<br>Would you take part exchange?<br>Thanks,<br><br>John") }

    context 'single line message' do
      let(:source_html){ File.open('spec/fixtures/amdirect-2.html').read }
      it { expect(enquiry.message).to eq("Is this vehicle still available?") }
    end
  end

  describe '.listing_make' do
    it { expect(enquiry.listing_make).to eq('Ford') }
  end

  describe '.listing_model' do
    it { expect(enquiry.listing_model).to eq('Focus') }
  end

  describe '.listing_year' do
    it { expect(enquiry.listing_year).to eq('2008') }
  end

  describe '.listing_colour' do
    it { expect(enquiry.listing_colour).to eq('blue') }
  end

  describe '.listing_url' do
    it { expect(enquiry.listing_url).to eq('/amdirect-1-listing.html') }
  end

  describe '.listing_reference' do
    it { expect(enquiry.listing_reference).to eq('AMD-FF1') }
  end
end
