class Api::CommentLoader < Api::QuestGamesRequest

  self.sub_uri = '/site/getMoreComments'

  def all_comments
    more_comments_exist = true
    offset              = 0
    result_comments     = []

    while more_comments_exist do
      comments = next_comments(offset: offset)

      offset += comments.length
      more_comments_exist = comments.length > 0

      result_comments += comments
    end

    result_comments
  end

  def next_comments(offset:)
    params = {
      query: {
        offset:  offset,
        questId: quest_id,
      }
    }

    JSON.parse(
      get_request(params)
    )['responce'].map { |comment| comment['content'] }
  end

end
