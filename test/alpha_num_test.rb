require_relative "../lib/te_rex"
require "test/unit"
class AlphaNumTest < Test::Unit::TestCase

  #test "generates array of lowercase roman characters" do
  def generate_array_lower
    res = TeRex::AlphaNum.gen
    ('a'..'z').each {|char| assert_equal res.include? char}
  end

  #test "generates array of uppercase roman characters" do
  def generate_array_upper
    res = TeRex::AlphaNum.gen
    ('A'..'Z').each {|char| assert_equal res.include? char}
  end

  #test "generates array of integers 1-20" do
  def generate_array_integer
    res = TeRex::AlphaNum.gen
    (1..20).each {|int| assert_equal res.include? int}
  end
end
