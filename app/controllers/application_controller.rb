class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def render_not_found_response(exception)
    render json: { errors: { detail: exception.message } }, status: :not_found
  end

  def render_unprocessable_entity_response(exception)
    render json: { errors: { detail: exception.message } }, status: :unprocessable_entity
  end
end
