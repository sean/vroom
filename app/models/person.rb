class Person < ActiveRecord::Base
  validates :name, presence: true
  validates :title, presence: true
end
