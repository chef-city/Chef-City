require "digest"
class User < ActiveRecord::Base
  validates :email, :uniqueness=>true, :presence=>true
  validates :password, :presence=>true

  def encrypt_password
    self.salt ||= generate_salt
    self.password = Digest::MD5.hexdigest(self.salt + self.password)
  end

  def password_matches?(candidate_password)
    self.password == Digest::MD5.hexdigest(self.salt + candidate_password)
  end

  private
  def generate_salt
    salt = ""
    1.upto(5) do
      salt+= rand(9).to_s
    end
  end
end
