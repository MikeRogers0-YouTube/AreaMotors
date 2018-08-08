class EnquiriesController < ApplicationController
  before_action :set_enquiry, only: [:show]

  # GET /enquiries
  def index
    @enquiries = Enquiry.all
  end

  # GET /enquiries/1
  def show
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
