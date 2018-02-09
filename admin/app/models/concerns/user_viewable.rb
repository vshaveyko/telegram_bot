# :nodoc:
module Concerns::UserViewable

  extend ActiveSupport::Concern

  included do
    has_many :user_views, -> { where(valid: true) }, as: :viewable, dependent: :destroy

    def self.invalidate
      update_all(valid: false)
    end
  end

end
