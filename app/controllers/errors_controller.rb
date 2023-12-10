class ErrorsController < ApplicationController
  def not_found
    authorize :errors, :not_found?
    render status: 404, template: 'errors/not_found', formats: [:html]
  end

  def internal_server_error
    authorize :errors, :internal_server_error?
    render status: 500
  end
end
