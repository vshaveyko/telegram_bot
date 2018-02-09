class ApplicationRecord < ActiveRecord::Base

  self.abstract_class = true

  scope :randomize, -> { order("RANDOM()") }

end
