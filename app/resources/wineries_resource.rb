class WineriesResource < BaseResource
  def allowed_methods
    %w[GET HEAD]
  end

  def resource_exists?
    @wineries = Winery.all

    @wineries.any?
  end

  def protected_resource?
    true
  end
end
