# :nodoc:
class Api::Request

  include ::HTTParty

  class << self

    attr_accessor(:sub_uri)

    def get(options = {})
      super(sub_uri, **options)
    end

  end

  def response
    @response ||= JSON.parse(get_request)
  end

  # redefine
  def request_params
    {}
  end

private

  def get_request(params = request_params)
    Rails.cache.fetch("#{self.class.sub_uri}___#{params.to_json}", raw: true, expires_in: 10.minutes ) do
      self.class.get(params).body
    end
  end

end
