Google Geocoding API for Ruby
=========================================================

Google Geocoding API をRubyから利用しやすくしました。
Google Geocoding API V3が対象です。

http://code.google.com/intl/ja/apis/maps/documentation/geocoding/

Version
-------

+ 0.0.1 2011/04/21リリース

Usage 
-----

gemでjsonをインストールしてください

+ json  

Geocodingクラスはgeocodeクラスメソッドしか持っていません。

    require 'geocoding'
    Geocoding.geocode( :address => '日本橋' ) #=> jsonオブジェクト

geocodeメソッドの詳細は以下の通りです

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
    end

Todo
----
 
+ パラメータを指定する時に、支援機能が欲しいかも。

copyright 2010 waco, released under the MIT license 
