require 'digest'

class User < ActiveRecord::Base

  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
  has_many :tickets, :dependent => :destroy

  validates :name,  :presence => true, :length => { :maximum => 50 }
  validates :email, :presence => true, :uniqueness => { :case_sensitive => false },
            :length => { :maximum => 150 }, :format => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, :presence => true, :confirmation => true, :length => { :within => 6..40 }

  before_save :encrypt_password

  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    user && user.has_password?(submitted_password) ? user : nil
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  def has_password?(submitted_password)
    crypt_password == encrypt(submitted_password)
  end

  def revision_tickets
    tickets.where(:ok => false)
  end

  def closed_tickets
    tickets.where(:ok => true)
  end

  private

    def encrypt_password
      self.salt = make_salt if new_record?
      self.crypt_password = encrypt(password)
    end

    def encrypt(value)
      secure_hash("#{salt}--#{value}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(value)
      Digest::SHA2.hexdigest(value)
    end
end
