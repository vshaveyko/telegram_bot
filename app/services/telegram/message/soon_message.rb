# :nodoc:
class Telegram::Message::SoonMessage < Telegram::Message

  MESSAGE = /(скоро)/

  def call
    send_message(
      text: 'Эта кнопка пока что не работает. Мы запрограммируем ее скоро и оповестим вас. Спасибо что пользуетесь приложением'
    )
  end

end
