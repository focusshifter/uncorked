json.ignore_nil!

json._links do |l|
  l.self do |slf|
    slf.href urlify(SignupResource)
    slf.title 'Signup'
  end
end

json.email @user.email
json.name @user.name
json.created_at @user.created_at
json.token @token
