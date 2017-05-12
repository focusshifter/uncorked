# = EntrypointResource
#
# GET "/"
class EntrypointResource < BaseResource
  def allowed_methods
    %w[GET HEAD]
  end

  def resource_exists?
    true
  end
end
