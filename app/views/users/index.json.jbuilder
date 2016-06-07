json.data @users do |user|
		json.id user.id
    json.name user.full_name
    json.email user.email
end