json.ignore_nil!

json._links do |l|
  l.self do |slf|
    slf.href urlify(LoginResource)
    slf.title 'Login'
  end
end

json.token @token
