module UsersHelper

	def gravatar_for(user)
		gravatar_id=Digest::MD5::hexdigest(user.email.downcase)
		gravater_url="https://secure.gravatar.com/avatars/#{ gravatar_id }.png"
		image_tag(gravater_url, alt: user.name, class: "gravatar" )
	end
end

