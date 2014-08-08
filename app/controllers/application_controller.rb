class ApplicationController < ActionController::Base
  rescue_from StandardError, :with => :handle_exception
  before_action :check_for_mock

  protect_from_forgery with: :exception

  # tk:
  # ref: http://stackoverflow.com/questions/14734243/rails-csrf-protection-angular-js-protect-from-forgery-makes-me-to-log-out-on
  # ref: http://stackoverflow.com/a/15761835/2371903
  #
  after_filter :set_csrf_cookie_for_ng

  def set_csrf_cookie_for_ng
    logger.debug { "set-csrf-cookie-for-ng: form-authenticity-token=#{form_authenticity_token}, protect-against-forgery?=#{protect_against_forgery?}" }
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected

  def handle_exception(e)
    if request.path =~ /^\/api/
      case e
      when ActiveRecord::RecordNotFound
        message = 'not found'
        status = :not_found
      else
        status = :bad_request
        logger.warn {"handle-exception: [#{e.to_s}]\n\t#{e.backtrace.join("\n\t")}"}
      end

      render json: {message: (message or e.to_s)}, status: status
    else
      raise e
    end
  end

  def verified_request?
    xsrf_token = request.headers['X-XSRF-TOKEN']
    logger.debug { "verified-request?: form-authenticity-token=#{form_authenticity_token}, X-XSRF-TOKEN=#{xsrf_token}" }
    super || form_authenticity_token == xsrf_token
  end

  def check_for_mock
    # eg: "action"=>"category", "controller"=>"api/claims"
    path_elts = ['mock'].concat(params[:controller].split('/')).push(params[:action])

    # Settings.mock.api.claims.category = true ?
    memo = Settings
    should_mock = path_elts.all? {|attr| memo = memo[attr] }

    if (should_mock)
      file = "#{Rails.root}/mock/#{params[:controller]}/#{params[:action]}.json"
      logger.debug { "check-for-mock: mocking active for path=/#{params[:controller]}/#{params[:action]}, serving file=#{file}" }
      render file: file, status: 200, layout: false, content_type: 'application/json'
    end
  end

  def org
    logger.debug { "org: current-user=#{current_user.inspect}" }
    current_user.organization
  end

  def default_serializer_options
    {root: false}
  end
end
