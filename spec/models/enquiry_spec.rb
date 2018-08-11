require 'rails_helper'

RSpec.describe Enquiry, type: :model do
  describe 'Validations' do
    describe :custom_state do
      let(:enquiry){ Enquiry.new(state: :open) }
      it 'Must be present when state is custom' do
        enquiry.valid?
        expect(enquiry.errors.keys).to_not include(:custom_state)

        enquiry.state = :custom
        enquiry.valid?
        expect(enquiry.errors.keys).to include(:custom_state)

        enquiry.custom_state = 'Special State'
        enquiry.valid?
        expect(enquiry.errors.keys).to_not include(:custom_state)
      end
    end
  end

  describe '#search' do
    let!(:enquiry_1){ Enquiry.create!(name: 'Sarah-Jane Hardigan', email: 'sjhardigan@mailinator.com', message: 'Example Message', listing_url: 'some-file.html') }
    let!(:enquiry_2){ Enquiry.create!(name: 'John Smith', email: 'johnsmith@mailinator.com', message: 'Example Message', listing_url: 'some-file-2.html') }

    it 'performs a case insentive wildcard match against the name & email field' do
      expect(Enquiry.search('sarah-jane')).to eq([enquiry_1])
      expect(Enquiry.search('Smith')).to eq([enquiry_2])

      expect(Enquiry.search('sjhardigan@mailinator.com')).to eq([enquiry_1])
      expect(Enquiry.search('johnsmith@mailinator.com')).to eq([enquiry_2])

      expect(Enquiry.search('mailinator.com')).to eq([enquiry_1, enquiry_2])
    end
  end

  describe '#create_from_source' do
    let(:enquiry) { Enquiry.create_from_source( source: :a_m_direct, source_html: source_html) }

    context 'given an blank source_html' do
      let(:source_html) { '' }

      it 'Will return an unsaved enquiry' do
        expect(enquiry.persisted?).to eq(false)
      end
    end

    context 'given an source_html with a duplicated listing_url' do
      let(:source_html) { File.open('spec/fixtures/amdirect-1.html').read }

      before do
        Enquiry.create_from_source( source: :a_m_direct, source_html: source_html)
      end

      it 'Will return an unsaved enquiry' do
        expect(Enquiry.count).to eq(1)
        expect(Enquiry.first.listing_url).to eq(enquiry.listing_url)
        expect(enquiry.persisted?).to eq(false)
      end
    end

    context 'given an source_html with an invaid email' do
      let(:source_html) { File.open('spec/fixtures/amdirect-2-invalid-email.html').read }

      it 'Will return an saved Enquiry with the state "invalid"' do
        expect(enquiry.persisted?).to eq(true)
        expect(enquiry.state).to eq('invalid')
      end
    end

    context 'given an source_html with an vaid email' do
      let(:source_html) { File.open('spec/fixtures/amdirect-1.html').read }

      it 'Will return an saved Enquiry with the state "open"' do
        expect(enquiry.persisted?).to eq(true)
        expect(enquiry.state).to eq('open')
      end
    end
  end

  describe '.verify_email_quality!' do
    let(:enquiry){ Enquiry.new(email: 'sjhardigan@mailinator.com') }

    context 'a valid email' do
      it 'Keeps the enquiry.state as "open"' do
        expect{ enquiry.send(:verify_email_quality!) }.to_not change{ enquiry.state }
      end
    end

    context 'an invalid email' do
      let(:enquiry){ Enquiry.new(email: 'invalid-email') }

      it 'Changes the enquiry.state to "invalid"' do
        expect{ enquiry.send(:verify_email_quality!) }.to change{ enquiry.state }.from('open').to('invalid')
      end
    end
  end
end
