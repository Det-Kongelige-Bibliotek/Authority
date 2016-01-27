module Authority
  class ApplicationController < ActionController::Base
    layout 'application' # use the parent appliactions layout

    # simple methor to delegate missing path helper to the main app
    # a bit of a hack
    def method_missing method, *args, &block
      method.to_s.end_with?('_path', '_url') and main_app.respond_to?(method) ? main_app.send(method, *args) : super
    end

  end
end
