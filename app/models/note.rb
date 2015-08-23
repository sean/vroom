class Note < ActiveRecord::Base
  belongs_to :person

  validates :details, presence: true
end
