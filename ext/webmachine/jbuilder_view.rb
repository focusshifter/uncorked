require 'tilt/jbuilder'

module Webmachine
  # = JbuilderView
  #
  # Extends resource with an ability to render itself via Jbuilder
  #
  # FIXME: currently conflicts with Webmachine trace proxies, second call to the
  # same resource returns broken proxy instead of the render result.
  module JbuilderView
    def render(template_name = default_template_name)
      template_path = "./app/views/#{template_name}.json.jbuilder"

      Tilt::JbuilderTemplate.new(template_path).render(self)
    end

    private

    def default_template_name
      self.class.name.to_s.underscore
    end
  end
end
