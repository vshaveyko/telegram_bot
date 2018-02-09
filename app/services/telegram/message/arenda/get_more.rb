# :nodoc:
class Telegram::Message::Arenda::GetMore < Telegram::Message

  include Telegram::Message::Arenda::Location

  MESSAGE = '/arenda_get_more'

  def call
    return unless user.current_position

    super
  end

end
