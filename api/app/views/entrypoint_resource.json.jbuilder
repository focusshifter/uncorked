json.ignore_nil!

json._links do |l|
  l.self do |slf|
    slf.href urlify_base
    slf.title 'API Entrypoint'
  end

  l.wineries do |wineries|
    wineries.href urlify(WineriesResource)
    wineries.title 'The collection of Wineries'
  end

  l.winery do |winery|
    winery.href templated_url(WineriesResource, '/{id}')
    winery.templated true
  end

  l.wines do |wines|
    wines.href urlify(WinesResource)
    wines.title 'The collection of Wines'
  end

  l.wine do |wine|
    wine.href templated_url(WinesResource, '/{id}')
    wine.templated true
  end

  l.login do |login|
    login.href urlify(LoginResource)
    login.title 'Get an auth token'
  end

  l.signup do |signup|
    signup.href urlify(SignupResource)
    signup.title 'Register as a new user'
  end
end
