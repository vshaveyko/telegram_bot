# :nodoc:
module HttpPartyProxied

  class << self

    attr_accessor :proxies

  end

  # manager = ProxyFetcher::Manager.new(filters: { maxtime: '100' })
  #
  # self.proxies = manager.proxies

  # def self.included(base)
  #   proxy = proxies.sample
  #
  #   base.http_proxy proxy.addr, proxy.port
  # end
  #
  # def initialize
  #   @proxy = self.class.proxies.sample
  # end
  #
  # options = {http_proxyaddr: proxy.host,http_proxyport:proxy.port, http_proxyuser:proxy.user, http_proxypass:proxy.password}
  # response = HTTParty.get('http://ip.jsontest.com/',options)
  #
  # def http_party_proxy_config
  #
  # end
  #

end
