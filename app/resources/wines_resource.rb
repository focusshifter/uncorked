class WinesResource < BaseResource
  def allowed_methods
    %w[GET HEAD]
  end

  def resource_exists?
    true
  end

  def to_json
    @wines = Wine.all

    render
  end
end
