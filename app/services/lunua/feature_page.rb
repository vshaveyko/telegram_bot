# frozen_string_literal: true
# :nodoc:
class Lunua::FeaturePage

  attr_reader :page
  def initialize(page, feature)
    @page    = page
    @feature = feature
  end

  MAX = 200
  def text
    @text ||= begin
      # hash = {
      #   'address'          => address,
      #   'price'            => ,
      #   'last updated at'  => formatted_datetime(@page['time']['updateTime']),
      #   'realty features:' => realty_features
      # }
      #
      # hash['house features: '] = house_features if realty_features != house_features
      #
      # table = formatted_hash_output(hash) + "\n"
      # table + @page['description']['text'][0..(MAX - table.length - 3)] + '...'
      """
        #{address}
#{@page['price']}

#{realty_features}
#{house_features}

#{@page['description']['text']}
      """
    end
  end

  def show_more_url
    @show_more_url ||= begin
      source_link = @page['sourceLink']
      'https://www.lun.ua' + source_link['url'].to_s
    end
  end

  def photo_url
    @photo_url ||= @page['photo']['url']
  end

  def title
    @title ||= @page['photo']['title']
  end

  def lat
    @lat ||= @feature.geometry_lat
  end

  def long
    @long ||= @feature.geometry_long
  end

  def address
    return @adress if defined?(@address)

    address_info = @page['geo']['address']

    @address = [address_info['streetOrBuildingFull'].to_s, address_info['house'].to_s].join(', ')
  end

  private

  def realty_features
    @realty_features ||= (@page['realtyFeatures'] || []).map { |f| f['value'] }.join(', ')
  end

  def house_features
    @house_features ||= (@page['houseFeatures'] || []).map { |f| f['value'] }.join(', ')
  end

  def formatted_value(label, value, width)
    format("%s %#{width}s\n", label, value)
  end

  def formatted_datetime(string)
    DateTime.parse(string).strftime('%d/%m/%y, %H:%M')
  end

  def formatted_hash_output(h)
    size = h.keys.max_by(&:length).length + 1
    m    = h.map { |k, v| k + ' ' * (size - k.length) + v }.join("\n")
  end

end
