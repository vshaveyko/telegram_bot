# :nodoc:
class Telegram::Location::RequestUpdate < Telegram::Base

  MESSAGE = /#{Telegram::Commands::RESET_BUTTON}/

  def call
    sender.send_message(
      text: 'Мы выдаем самый ближайший к вам квест, ' \
            'но не знаем поменяли ли вы за последнее время месторасположение. ' \
            'Пожалуйста обновите локацию :)',
      buttons: [ Telegram::Commands.update_location_button ]
    )
  end

end
