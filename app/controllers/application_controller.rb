class ApplicationController < ActionController::Base
  set_current_tenant_by_subdomain_or_domain(:account, :subdomain, :domain)
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
end
