json.ignore_nil!

json._links do |l|
  l.self do |slf|
    slf.href urlify(WineriesResource)
    slf.title 'The collection of Wineries'
  end
end

json._embedded do
  json.wineries @wineries do |winery|
    json._links do |l|
      l.self do |slf|
        slf.href urlify(WineryResource, id: winery.uuid)
        slf.title winery.title
      end
    end

    json.id winery.uuid
    json.title winery.title
  end
end
