class CustomerNotesController < ApplicationController
  def create
    resource.attributes = resource_params
    resource.save!

    redirect_to url_for(parent_resource), notice: t('.notice')
  end

  private
  def parent_resource
    @parent_resource ||= Customer.find(params[:id])
  end

  def resource
    @resource ||= parent_resource.customer_notes.new
  end

  def resource_params
    params.require(:customer_note).permit(:body)
  end
end
