# :nodoc:
class GoogleAnalytics

  class << self

    def track(t_message, message_info, message)
      tracker = Staccato.tracker('UA-110485368-1', message_info.user.id)

      tracker.pageview(path:     message.text,
                       hostname: 'harvey_bot.com',
                       title:    t_message.class::MESSAGE,
                       user_id:  message_info.user.id)
    end


  end

end
