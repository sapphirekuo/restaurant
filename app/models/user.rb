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

  # 「使用者Like很多餐廳」的多對多關聯
  has_many :likes, dependent: :destroy
  has_many :liked_restaurants, through: :likes, source: :restaurant

  # 「使用者追蹤美食達人」的多對多關聯
  has_many :followships, dependent: :destroy
  has_many :followings, through: :followships
  # 使用者的追蹤者：@user.followers
  has_many :inverse_followships, class_name: "Followship", foreign_key: "following_id"
  has_many :followers, through: :inverse_followships, source: :user

  # 使用者的朋友： @user.friends
  has_many :friendships, dependent: :destroy #, class_name: "friendship", primary_key: "id", foreign_key: "user_id"
  has_many :friends, through: :friendships #, source: :friend
  # 已加使用者為好友的人 @user.friendlys
  has_many :inverse_friends, class_name: "Friendship", foreign_key: "friend_id"
  has_many :friendlys, through: :inverse_friends, source: :user

  def all_friends
    friends = (self.friends + self.friendlys).uniq
  end

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

  def following?(user)
    self.followings.include?(user)
  end

  def friend?(user)
    self.friends.include?(user)
  end

  def friendlys?(user)
    self.friendlys.include?(user)
  end
end
