# frozen_string_literal: true

require('oj')

class Lunua::ResponseParser

  def initialize(response)
    @response = response
  end

  def parse
    Oj.load(@response.body)['features']
  end

end
