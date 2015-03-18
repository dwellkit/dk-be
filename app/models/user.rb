class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable

  has_many :groundskeepers
  has_many :properties, through: :groundskeepers

  has_many :addresses, through: :properties
  has_many :items
  has_many :contacts, as: :reachable
  has_many :reminders
  has_many :events


  before_save :ensure_authentication_token

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def as_json(opts={})
    options = {:only => [:email, :authentication_token]}
    options.merge!(opts)
    super(options)
  end

  private
  def generate_authentication_token
    loop do
      if self.confirmed_at?
        token = Devise.friendly_token
        break token unless User.where(authentication_token: token).first
      else
        return Devise.friendly_token
      end
    end
  end
end
