class WinesResource < BaseResource
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
    url_for(WineResource, id: next_id)
  end

  def from_json
    @winery = Winery.find(uuid: params['winery_id'])

    return json_errors(winery_id: 'Could not find winery with id') unless @winery

    create_wine
  end

  def create_wine
    wine_params = params.reject { |key, _value| ['winery_id'].include? key }

    @wine = Wine.new(wine_params)
    @wine.winery = @winery
    @wine.uuid = next_id

    return json_validation_errors(@wine) unless @wine.valid?

    @wine.save

    response.body = render('wine_resource')
  end

  def next_id
    @next_id ||= SecureRandom.uuid
  end

  def to_json
    @wines = Wine.all

    render
  end
end
