class User < ActiveRecord::Base
	has_many :statuses
      before_save :format_user_input

	attr_reader :password

  def password=(unencrypted_password)
  	unless unencrypted_password.empty?
    		@password = unencrypted_password
    		self.password_digest = BCrypt::Password.create(unencrypted_password)
    	end
  end

  def authenticate(unencrypted_password)
    if BCrypt::Password.new(self.password_digest) ==  unencrypted_password
      return self
    else
      return false
    end
  end

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false}, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, presence: true, confirmation: true, length: { in: 6..20 }
  private
  def format_user_input
    self.first_name = self.first_name.titleize
    self.last_name = self.last_name.titleize
    self.email = self.email.downcase
  end

end