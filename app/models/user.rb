class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  # 如果 User 已經有了評論，就不允許刪除帳號（刪除時拋出 Error）
  has_many :comments, dependent: :restrict_with_error
  has_many :restaurants, through: :comments

  # 「使用者收藏很多餐廳」的多對多關聯
  has_many :favorites, dependent: :destroy
  has_many :favorited_restaurants, through: :favorites, source: :restaurant


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
