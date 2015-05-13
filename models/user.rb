class User < Sequel::Model
  def self.from_auth(auth_hash)
    u = new
    u.email = auth_hash[:uid]

    if auth_hash[:provider] == 'pocket'
      u.pocket_token = auth_hash[:credentials][:token]
    end

    return u
  end
end
