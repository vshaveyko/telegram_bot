# :nodoc:
class Telegram::Base

  class << self

    def messages
      @messages ||= descendants
    end

  end

  attr_reader :sender, :message_info

  delegate :user, :quest, :quest_location, to: :@message_info

  def initialize(sender, message_info)
    @sender       = sender
    @message_info = message_info
  end

private

  def delegate_message_to(delegator_klass)
    delegator_klass.new(sender, @message_info).call
  end

end
