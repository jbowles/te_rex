require_relative "../lib/trex"
class AlphaNumTest < MicroTest::Test

  test "generates array of lowercase roman characters" do
    res = Trex::AlphaNum.gen
    ('a'..'z').each {|char| assert res.include? char}
  end

  test "generates array of uppercase roman characters" do
    res = Trex::AlphaNum.gen
    ('A'..'Z').each {|char| assert res.include? char}
  end

  test "generates array of integers 1-20" do
    res = Trex::AlphaNum.gen
    (1..20).each {|int| assert res.include? int}
  end
end
