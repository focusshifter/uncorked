module Webmachine
  module Linking
    # = Urlify
    #
    # Collection of helpers to make the resource-linking easier (in the future).
    module Urlify
      include Webmachine::Linking::Resource::LinkHelpers

      # Provides an absolute link for a given resource.
      #
      # Currently unused, remove :nocov: on first use.
      #
      # :nocov:
      def urlify(resource, vars = {})
        new_uri = request.base_uri
        new_uri.path = url_for(resource, vars)
        new_uri.to_s
      end
      # :nocov:
    end
  end
end
