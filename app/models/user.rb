class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  has_many :comments, dependent: :destroy
  has_many :restaurants, through: :comments, dependent: :destroy


  # if name is the required field
  #   validates_presence_of :name

  # or use the name part of email as default name
  before_save :default_name
  before_update :default_name

  def default_name
    if self.name == '' || self.name == nil
      self.name = self.email.split('@').first
    end
  end


  def admin?
    self.role == "admin"
  end


end
