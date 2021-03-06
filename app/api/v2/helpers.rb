module V2
  module Helpers

    def json_wrapper(msg = '', code = 0, data)
      { msg: msg, code: code, data: data }
    end

    alias :wrapper :json_wrapper

    def current_user
      request = Grape::Request.new(env)
      headers = request.headers
      token = headers['X-Token'].to_s

      @current_user = User.find_by(token: token)
    end

    def authenticate!
      if current_user.blank?
        raise AuthorizationError
      end
    end

    def template_path(path)
      env['api.tilt.template'] = "v2/views/#{path}"
    end

    def date_expired
      wrapper('date expired', 2015, false)
    end

  end

###############################################################################
  class Error < Grape::Exceptions::Base
    attr :code, :text

    def initialize(opts={})
      @code    = opts[:code]   || ''
      @text    = opts[:text]   || ''
      @status  = opts[:status] || ''

      @message = {msg: @text, code: @code}
    end
  end

  class AuthorizationError < Error
    def initialize
      super code: 1001, text: 'Authorization failed', status: 403
    end
  end

  class PermissionDeniedError < Error
    def initialize
      super code: 1003, text: 'Permission denied', status: 403
    end
  end

  class TokenExpiredError < Error
    def initialize
      super code: 1004, text: 'Token expired', status: 403
    end
  end

  class ResourceNotFoundError < Error
    def initialize
      super code: 2001, text: 'resource not found', status: 404
    end
  end
end
