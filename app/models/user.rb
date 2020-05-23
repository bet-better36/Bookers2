class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books,dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image

  validates :name, presence: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  has_many :follower, class_name: "Relationship",
                     foreign_key: "follower_id",
                         dependent: :destroy # フォロー取得
  has_many :following, class_name: "Relationship",
                     foreign_key: "following_id",
                       dependent: :destroy # フォロワー取得
  has_many :following_user, through: :follower, source: :following # 自分がフォローしている人
  has_many :follower_user, through: :following, source: :follower # 自分をフォローしている人

  # ユーザーをフォローする
  def follow(user_id)
    following.create( follower_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    following.find_by( follower_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    follower_user.include?(user)
  end
end