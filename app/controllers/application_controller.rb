class ApplicationController < ActionController::API
  def health_checks
    render json: {ok: true}
  end
end
