class WineResource < BaseResource
  def allowed_methods
    %w[GET HEAD DELETE]
  end

  def resource_exists?
    wine
  end

  def protected_resource?
    true
  end

  def wine
    @wine ||= Wine.find(uuid: request.path_info[:id])
  end

  def delete_resource
    wine.destroy

    true
  end
end
