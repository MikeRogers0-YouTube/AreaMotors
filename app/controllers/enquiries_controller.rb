class EnquiriesController < ApplicationController
  before_action :set_enquiry, only: [:show]

  # GET /enquiries
  def index
    @enquiries = Enquiry.all
  end

  # GET /enquiries/1
  def show
  end

  # POST /enquiries/fetch_new
  def fetch_new
    fetched_enquiries_count = [
      Enquiry.create_from_source(source: :a_m_direct, source_url: '/amdirect-1.html', source_html: Rails.root.join('public/amdirect-1.html').read),
      Enquiry.create_from_source(source: :a_m_direct, source_url: '/amdirect-2.html', source_html: Rails.root.join('public/amdirect-2.html').read),
      Enquiry.create_from_source(source: :cars_for_sale, source_url: '/carsforsale-1.html', source_html: Rails.root.join('public/carsforsale-1.html').read)
    ].select(&:persisted?).count

    redirect_to({ action: :index }, {
      notice: t('.notice', { fetched_enquiries_count: fetched_enquiries_count })
    })
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enquiry
      @enquiry = Enquiry.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def enquiry_params
      params.require(:enquiry).permit(:name, :email, :message, :source, :listing_make, :listing_model, :listing_year, :listing_colour, :listing_url, :listing_reference)
    end
end
