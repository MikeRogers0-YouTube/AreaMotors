class EnquiriesController < ApplicationController
  # GET /enquiries
  def index; end

  # GET /enquiries/1
  def show; end

  # PATCH /enquiries/1/state_done
  def state_done
    resource.state_done!

    redirect_to url_for(resource), notice: t('.notice')
  end

  # POST /enquiries/fetch_new
  def fetch_new
    # TODO: It would be kind of neat to process this in an ActiveJob.
    # FIXME: Should this be shored up against a failure like a blank/incorrect source_HTML?
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
  helper_method :resource
  def resource
    @resource = Enquiry.find(params[:id]).decorate
  end

  helper_method :collection
  def collection
    if params[:query].present?
      Enquiry.search(params[:query]).decorate
    else
      Enquiry.all.decorate
    end
  end
end
