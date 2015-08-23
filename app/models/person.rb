class Person < ActiveRecord::Base
  has_many :notes
  
  validates :name, presence: true
  validates :title, presence: true
end
