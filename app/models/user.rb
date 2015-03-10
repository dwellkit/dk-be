class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User
  has_many :groundskeepers
  has_many :properties, through: :groundskeepers
  has_many :items
  has_many :contacts
  has_many :reminders
end
