module Webmachine
  module Linking
    # = Urlify
    #
    # Collection of helpers to make the resource-linking easier (in the future).
    module Urlify
      include Webmachine::Linking::Resource::LinkHelpers

      # Provides an absolute link for a given resource.
      def urlify(resource, vars = {})
        new_uri = request.base_uri.dup
        new_uri.path = url_for(resource, vars)
        new_uri.to_s
      end

      def urlify_base
        request.base_uri.to_s
      end

      def templated_url(resource, template, vars = {})
        "#{urlify(resource, vars)}#{template}"
      end
    end
  end
end
