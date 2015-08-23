class Person < ActiveRecord::Base
  has_many :notes, dependent: :delete_all
  
  validates :name, presence: true
  validates :title, presence: true
end
