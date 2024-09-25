class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  # Relaciones para el sistema de seguir/ser seguido
  has_many :follows, foreign_key: :follower_id, class_name: "Follow", dependent: :destroy
  has_many :followed_users, through: :follows, source: :followed

  has_many :inverse_follows, foreign_key: :followed_id, class_name: "Follow", dependent: :destroy
  has_many :followers, through: :inverse_follows, source: :follower

  def following?(other_user)
    followed_users.include?(other_user)
  end

  def follow(other_user)
    followed_users << other_user unless following?(other_user) || other_user == self
  end

  def unfollow(other_user)
    followed_users.delete(other_user)
  end
end
