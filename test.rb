require 'test/unit'
require 'geocoder'

class TestGeocoder < Test::Unit::TestCase
  def test_get_geocode
    assert_kind_of(Hash, Geocoder.geocode(:address => 'Tokyo'))
  end

  def test_good_parameter
    data = Geocoder.geocode(:address => 'Tokyo')
    assert_equal(data['status'], 'OK')
  end

  def test_bad_parameter
    data = Geocoder.geocode(:hoge => 1)
    assert_equal(data['status'], 'ZERO_RESULTS')
  end

  def test_get_geocode_by_json
    assert_kind_of(Hash, Geocoder.geocode(:address => 'Tokyo'), 'json')
    # short code
    assert_kind_of(Hash, Geocoder.geocode(:address => 'Tokyo'), 'j')
  end

  def test_get_geocode_by_raw
    assert_kind_of(String, Geocoder.geocode({:address => 'Tokyo'}, 'raw'))
    # short code
    assert_kind_of(String, Geocoder.geocode({:address => 'Tokyo'}, 'r'))
  end

  def test_get_geocode_by_openstruct
    data = Geocoder.geocode({:address => 'Tokyo'}, 'openstruct')
    assert_equal(data.status, 'OK')

    # short code
    data = Geocoder.geocode({:address => 'Tokyo'}, 'o')
    assert_equal(data.status, 'OK')
    assert_not_nil(data.results.first.geometry.location.lat)
  end
end

