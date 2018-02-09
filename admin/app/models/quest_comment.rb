class QuestComment < ApplicationRecord

  belongs_to :quest, counter_cache: :comments_count

end
