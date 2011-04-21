require 'rubygems'
require 'net/http'  
require 'cgi'  
require 'json'  
require 'ostruct'
  
class Geocoder  
  BASE_URL = "http://maps.google.com/maps/api/geocode/json"  
    
  # Google Geocoder APIへのリクエスト結果をパースして受け取る
  # jsonのみでxmlは対応していません
  #
  # - parameters: Geocoder APIで利用できるパラメータをハッシュで指定します
  #   詳しくは次を参照 http://code.google.com/intl/ja/apis/maps/documentation/geocoding/#GeocodingRequests
  #
  # - format: 受け取るデータのフォーマットを指定します（オプション, デフォルト: 'json')
  #   'json', 'j': パースされたjsonを返します
  #   'raw', 'rj': そのままのjsonを返します
  #   'openstruct', 'o': openstruct形式で返します 
  #
  # 例）
  #   Geocoder.geocode( :address => 'Tokyo' )
  #   Geocoder.geocode({ :address => 'Tokyo' }, 'openstruct')
  def self.geocode(parameters, format = 'json')  
    type = type.to_s
    # :sensorは必須オプション
    parameters = { :sensor => 'false' }.merge(parameters)

    query = parameters.collect{ |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&') 
    url = URI.parse("#{BASE_URL}?#{query}")  
    response = Net::HTTP.get(url)

    # パース開始
    begin
      case format.to_s
      when 'json', 'j'
        data = JSON::parse(response) 
      when 'openstruct', 'o'
        json = JSON::parse(response) 
        data = self.recursive_ostruct(json)
      when 'raw', 'r'
        data = response
      end
    rescue
      data = 'could not parse'
    end

    return data
  end  

  private

  def self.recursive_ostruct(data)
    if data.instance_of? Hash
      data.each { |k, v| data[k] = recursive_ostruct(v) }
      data = OpenStruct.new data
    elsif data.instance_of? Array
      data.each_with_index { |k, i| data[i] = recursive_ostruct(k) }
    end

    data
  end
end  

