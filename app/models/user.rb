require "digest"
class User < ActiveRecord::Base
  validates :email, :uniqueness=>true, :presence=>true
  validates :password, :presence=>true

  def password_matches?(candidate_password)
    puts "candidate #{candidate_password} salt: #{self.salt} password: #{self.password}"
    puts "digest: #{Digest::MD5.hexdigest(self.salt + candidate_password)}"
    self.password == Digest::MD5.hexdigest(self.salt + candidate_password)

  end

  def encrypt_password
    if (!self.salt)
      self.salt = generate_salt
      puts "encrypting: #{Digest::MD5.hexdigest(self.salt + self.password)} with salt: #{self.salt} and pass #{self.password}"
      self.password = Digest::MD5.hexdigest(self.salt + self.password)
    end

  end

  def save
    encrypt_password
    super
  end

  private
  def generate_salt
    salt = ""
    1.upto(5) do
      salt+= rand(9).to_s
    end
    salt
  end
end
