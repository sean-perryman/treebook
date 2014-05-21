class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #Data entry validations     
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :profile_name, presence: true, 
  							uniqueness: true,
  							format: {
  								#with: /^([a-zA-Z0-9_-])+$/, #BROKEN!
                  with: /\A[a-zA-Z0-9_\-]+\z/,
  								message: 'Must be formatted correctly.'
  							}

  has_many :statuses

  def full_name
  	first_name + " " + last_name
  end

  def gravatar_url
    #return gravatar url
    "http://gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase.strip)}"
  end
end
