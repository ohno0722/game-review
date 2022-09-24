class Review < ApplicationRecord
  validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true
  
  has_many :comments, dependent: :destroy
  belongs_to :user

  def self.search(search_word)
    Review.where(['category LIKE ?', "#{search_word}"])
  end

end
