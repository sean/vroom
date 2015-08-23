class Person < ActiveRecord::Base
  has_many :notes, dependent: :delete_all
  belongs_to :owner, class_name: "User"
  
  validates :name, presence: true
  validates :title, presence: true
end
