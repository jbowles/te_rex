require_relative "../lib/te_rex"
class AlphaNumTest < PryTest::Test

  test "generates array of lowercase roman characters" do
    res = TeRex::AlphaNum.gen
    ('a'..'z').each {|char| assert res.include? char}
  end

  test "generates array of uppercase roman characters" do
    res = TeRex::AlphaNum.gen
    ('A'..'Z').each {|char| assert res.include? char}
  end

  test "generates array of integers 1-20" do
    res = TeRex::AlphaNum.gen
    (1..20).each {|int| assert res.include? int}
  end
end
