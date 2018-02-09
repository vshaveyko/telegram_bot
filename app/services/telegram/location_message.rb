# frozen_string_literal: true
class Telegram::LocationMessage

  #
  # next_page - FeaturePage
  #
  def initialize(next_page)
    @next_page = next_page
  end

  def photo
    LOGGER.debug("Responding with page: \n" + @next_page.text)

    {
      photo:   @next_page.photo_url,
      caption: @next_page.text
    }
  end

  def show_button
    {
      text: 'Контакты арендодателя',
      url:  @next_page.show_more_url
    }
  end

  def message_text
    {
      text: @next_page.text
    }
  end

  def venue
    {
      latitude:  @next_page.lat,
      longitude: @next_page.long,
      title:     @next_page.title,
      address:   @next_page.address
    }
  end

end
