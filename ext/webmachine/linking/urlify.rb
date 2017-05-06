module Webmachine
  module Linking
    module Urlify
      include Webmachine::Linking::Resource::LinkHelpers

      def urlify(resource, vars = {})
        new_uri = request.base_uri
        new_uri.path = url_for(resource, vars)
        new_uri.to_s
      end
    end
  end
end
