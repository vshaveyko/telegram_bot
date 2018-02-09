class Telegram::Default < Telegram::Base

  def call
    sender.send_message(
      text: 'Эта кнопка пока что не работает. ' \
            'Мы запрограммируем ее скоро и оповестим вас. ' \
            'Спасибо что пользуетесь приложением',
      # reply_markup: Telegram::Message::Start::LOCATION_BUTTON
    )
  end

end
