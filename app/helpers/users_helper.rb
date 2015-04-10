module UsersHelper
      # Returns the Gravatar (http://gravatarcom/) for the given user.
    def gravatar_for(user, options = { size: 52})
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        size = options[:size]
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
        image_tag(gravatar_url, alt: user.name, class: "gravatar img-circle")
    end
end