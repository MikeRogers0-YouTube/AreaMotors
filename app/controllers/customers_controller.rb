class CustomersController < ApplicationController
  def index
  end

  def show
  end

  private
  helper_method :resource
  def resource
    @resource ||= Customer.find(params[:id]).decorate
  end

  helper_method :collection
  def collection
    @collection ||= Customer.all.decorate
  end
end
