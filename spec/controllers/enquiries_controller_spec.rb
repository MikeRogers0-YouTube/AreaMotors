require 'rails_helper'

RSpec.describe EnquiriesController, type: :controller do

  let!(:enquiry) do
    Enquiry.create_from_source( source: :a_m_direct, source_html: File.open('spec/fixtures/amdirect-1.html').read )
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: enquiry.to_param }
      expect(response).to be_successful
    end
  end
end
