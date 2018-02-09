# frozen_string_literal: true

# :nocov:
class Lunua::Request

  class << self

    attr_accessor(:sub_uri)

    def get(options = {})
      super(sub_uri, **options)
    end

  end

  include ::HTTParty
  base_uri 'https://www.lun.ua'
  headers('Host' => 'www.lun.iua')

end
