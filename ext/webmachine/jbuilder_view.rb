require 'tilt/jbuilder'

module Webmachine::JbuilderView
  def render
    t = Tilt::JbuilderTemplate.new(template_path)
    t.render self
  end

  private

  def template_path
    template_name = self.class.name.to_s.underscore
    "./app/views/#{template_name}.json.jbuilder"
  end
end
