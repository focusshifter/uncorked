json.ignore_nil!

json._links do |l|
  l.self do |slf|
    slf.href url_for(LoginResource)
    slf.title 'Your auth token'
  end
end

json.token @token
