class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token  
  include Response
  include ExceptionHandler

  def raise_bad_request
    head :no_content
  end

end
