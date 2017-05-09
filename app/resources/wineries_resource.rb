class WineriesResource < BaseResource
  def allowed_methods
    %w[GET HEAD POST]
  end

  def resource_exists?
    true
  end

  def protected_resource?
    true
  end

  def post_is_create?
    true
  end

  def create_path
    url_for(WineryResource, id: next_id)
  end

  def from_json
    @winery = Winery.new(params)
    @winery.uuid = next_id

    return json_validation_errors(@winery) unless @winery.valid?

    @winery.save

    response.body = render('winery_resource')
  end

  def next_id
    @next_id ||= SecureRandom.uuid
  end

  def to_json
    @wineries = Winery.all

    render
  end
end
