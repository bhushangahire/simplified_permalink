require 'test/unit'
require "#{File.dirname(__FILE__)}/../lib/simplified_permalink/string"
require 'rubygems'
require 'activesupport'

class TestString < Test::Unit::TestCase

  def test_to_url
    assert_equal "This is a Permalink".to_url, "this-is-a-permalink"
    assert_equal "Is this a Permalink?".to_url, "is-this-a-permalink"
    assert_equal "Yes, this is a Permalink?".to_url, "yes-this-is-a-permalink"
  end

  def test_to_url_for_special_characters
    assert_equal "about/this/site".to_url, "about-this-site"
    assert_equal "chunky-bacon", "chunky & bacon".to_url
    assert_equal "chunky-bacon", "chunky ------ bacon".to_url
  end

  def test_to_url_for_spaces
    assert_equal "chunky-bacon", "chunky   bacon".to_url
    assert_equal "chunky-bacon", "chunky bacon   ".to_url
    assert_equal "chunky-bacon", "   chunky bacon".to_url
  end

  def test_normalize
    assert_equal "aaa", "àáä".normalize
    assert_equal "c", "ç".normalize
    assert_equal "eee", "èéë".normalize
    assert_equal "iii", "ìíï".normalize
    assert_equal "n", "ñ".normalize
    assert_equal "ooo", "òóö".normalize
    assert_equal "uuu", "ùúü".normalize
  end

end
