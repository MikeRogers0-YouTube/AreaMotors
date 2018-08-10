require 'rails_helper'

RSpec.describe Enquiry, type: :model do
  describe '#search(query)' do
    let!(:enquiry_1){ Enquiry.create!(name: 'Sarah-Jane Hardigan', email: 'sjhardigan@mailinator.com', message: 'Example Message', source_url: 'some-file.html') }
    let!(:enquiry_2){ Enquiry.create!(name: 'John Smith', email: 'johnsmith@mailinator.com', message: 'Example Message', source_url: 'some-file-2.html') }

    it 'performs a case insentive wildcard match against the name & email field' do
      expect(Enquiry.search('sarah-jane')).to eq([enquiry_1])
      expect(Enquiry.search('Smith')).to eq([enquiry_2])

      expect(Enquiry.search('sjhardigan@mailinator.com')).to eq([enquiry_1])
      expect(Enquiry.search('johnsmith@mailinator.com')).to eq([enquiry_2])

      expect(Enquiry.search('mailinator.com')).to eq([enquiry_1, enquiry_2])
    end
  end

  describe '.verify_email_quality!' do
    pending
    let(:enquiry){ Enquiry.new(email: 'sjhardigan@mailinator.com') }

    context 'a valid email' do
      it 'Keeps the enquiry.state as "open"' do
        expect{ enquiry.verify_email_quality! }.to_not change{ enquiry.state }
      end
    end

    context 'an invalid email' do
      let(:enquiry){ Enquiry.new(email: 'invalid-email') }

      it 'Changes the enquiry.state to "invalid"' do
        expect{ enquiry.verify_email_quality! }.to change{ enquiry.state }.from('open').to('invalid')
      end
    end
  end
end
