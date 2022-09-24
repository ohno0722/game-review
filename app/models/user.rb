class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         enum gender: { man: 0, woman: 1}

  def self.guest
    find_or_create_by!(email: 'guest@example.com', age: 20) do |user|
      user.name = "ゲスト"
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

        has_many :reviews, dependent: :destroy
        has_many :comments, dependent: :destroy
end
