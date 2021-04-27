class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_unprocessable_entity_response

  def invalid_params
    render json: { error: 'invalid parameters' }, status: :bad_request
  end

  def bad_login
    render json: { error: 'bad credentials' }, status: 400
  end

  def render_unprocessable_entity_response(exception)
    render json: { error: exception.message }, status: 400
  end

  def unauthorized
    render json: { error: 'unauthorized request' }, status: 401
  end
end
