class Review < ApplicationRecord
    belongs_to :user
    belongs_to :trail
    validates :title, presence: true, length: {minimum: 3, maximum: 100} 
    validates :body, presence: true,  length: {minimum: 24, maximum: 2000} 
    validates :rating, presence: true
end
