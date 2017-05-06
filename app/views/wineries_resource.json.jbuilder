json._links do |l|
  l.self do |slf|
    slf.href url_for(WineriesResource)
  end
end

json._embedded do
  json.wineries @wineries do |winery|
    json._links do |l|
      l.self do |slf|
        slf.href url_for(WineryResource, id: winery.uuid)
      end

      l.wines do |wines|
        wines.href url_for(WinesResource, winery_id: winery.uuid)
      end
    end

    json.name winery.name
  end
end
