module ExceptionHandler
    extend ActiveSupport::Concern

    included do
      
        rescue_from ActiveRecord::RecordNotFound do |e|
            json_response({message: e.message}, :not_found)
        end

        rescue_from ActiveRecord::RecordInvalid do |e|
            json_response({message: e.message}, :unprocessable_entity)
        end

        rescue_from StandardError do |e|
          respond(:standard_error, 500, e.to_s)
        end

    end
end