# :nodoc:
class Telegram::Message::Arenda::GetClosest < Telegram::Message

  include Telegram::Message::Arenda::Location

  MESSAGE = 0

  def call
    if message.location.nil?
      return ask_for_location
    end

    long = message.location.longitude
    lat  = message.location.latitude

    user.update(
      last_position:    user.current_position,
      current_position: [long, lat]
    )

    user.invalidate_features!

    super
  end

end
