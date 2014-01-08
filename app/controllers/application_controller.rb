class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  if Settings.enable_csrf
    protect_from_forgery with: :exception
  end

  # tlk
  # ref: http://stackoverflow.com/questions/14734243/rails-csrf-protection-angular-js-protect-from-forgery-makes-me-to-log-out-on
  # ref: http://stackoverflow.com/a/15761835/2371903
  #
  after_filter :set_csrf_cookie_for_ng

  def set_csrf_cookie_for_ng
    logger.debug { "set-csrf-cookie-for-ng: form-authenticity-token=#{form_authenticity_token}, protect-against-forgery?=#{protect_against_forgery?}" }
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected

  def verified_request?
    xsrf_token = request.headers['X-XSRF-TOKEN']
    logger.debug { "verified-request?: form-authenticity-token=#{form_authenticity_token}, X-XSRF-TOKEN=#{xsrf_token}" }
    #if logger.debug?
    #  request.headers.each do |key, val|
    #    logger.debug { "headers[#{key}]=#{val}" }
    #  end
    #end
    super || form_authenticity_token == xsrf_token
  end

end
