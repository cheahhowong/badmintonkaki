require 'bcrypt'

class User < ApplicationRecord
	include BCrypt
	has_secure_password
	has_many :authentications, dependent: :destroy
  has_many :relationships
  has_many :events, through: :relationships

  before_create {generate_token(:auth_token)}
  attr_accessor :remember_me
  validates_presence_of :first_name, :last_name, :email, :password

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

	def self.create_with_auth_and_hash(authentication, auth_hash)
      if auth_hash.provider == 'google_oauth2'
        user = self.create!(
          first_name: auth_hash["info"]["first_name"],
          last_name: auth_hash["info"]["last_name"],
          email: auth_hash["info"]["email"],
          remote_users_avatar_url: auth_hash['extra']['raw_info']['picture'],
          password: SecureRandom.hex(16)
        )
        user.authentications << authentication
        return user
      else auth_hash.provider == 'facebook'
        user = self.create!(
          first_name: auth_hash["extra"]["raw_info"]["first_name"],
          last_name: auth_hash["extra"]["raw_info"]["last_name"],
          email: auth_hash["extra"]["raw_info"]["email"],
          password: SecureRandom.hex(16)
        )
        user.authentications << authentication
        return user
      end  
    end

    # grab fb_token to access Facebook for user data
    def fb_token
      x = self.authentications.find_by(provider: 'facebook')
      return x.token unless x.nil?
    end
    
end
