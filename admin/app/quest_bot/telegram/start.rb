class Telegram::Start < Telegram::Base

  MESSAGE = '/start'

  KB = [
    Telegram::Bot::Types::KeyboardButton.new(text: "Квесты рядом",
                                             request_location: true),
    # Telegram::Bot::Types::KeyboardButton.new(text: "Хочу посетить \u{1F408}"),
  ]

  def call
    sender.send_message(
      text: (<<~TEXT
      Привет. Я Харви и работаю только ☎️ с мобильного телефона.

      *Как я работаю?*
      Я беру твою локацию, и показываю какие квесты-пространства есть рядом с тобой.

      *Что нужно делать?*
      Просто нажать кнопку «Квесты рядом» или «Показать еще квесты». А дальше выбирать квесты, которые понравились.

      *Пользователям и квест-комнатам*
      Я улучшаюсь с каждым днем, но баги все еще возможны. Если у тебя есть идеи как меня улучшить или ты хочешь добавить свой квест пиши на harvibot@gmail.com
      TEXT
             ),
      buttons: KB
    )
  end


end
