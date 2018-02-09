class MessageUserInfo

  def initialize(message)
    @message = message
  end

  def update_user!
    LOGGER.info("message info : #{ @message }")

    update_latest_message_date
    update_user_location
  end

  def user
    @user ||= begin
               user_info = @message.from

               ::QuestUser.find_or_create_by!(telegram_user_id: user_info.id.to_s) do |new_user|
                 new_user.username   = user_info.username
                 new_user.first_name = user_info.first_name
                 new_user.last_name  = user_info.last_name
               end
             end
  end

private

  def update_latest_message_date
    user.update!(
      latest_message_at: DateTime.current
    )
  end

  def update_user_location
    if @message.location
      User::UpdateLocation.new(user, @message).call
    end
  end

end
