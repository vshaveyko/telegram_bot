# :nodoc:
class ScheduleItemPresenter

  def initialize(item)
    @item = item.stringify_keys
  end

  def price
    @item['price']
  end

  def time
    @item['time']
  end

  def busy?
    @item['is_busy']
  end

  def not_busy?
    !busy?
  end

  def present_selected
    <<~TEXT
    TIME:    #{time}
    PRICE:   #{price}
    IS_BUSY: #{busy?}
    TEXT
  end

end
