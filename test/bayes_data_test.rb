require_relative "../lib/trex"
class BayesDataTest < MicroTest::Test

  test "punctuation is removed" do
    s1 = "This * punctuation se%ntence ).!"
    s2 = "Much $ in @ this } [ sentence too?"
    s3 = "And I$ have c#des in |his one too@>."

    @s11 = Trex::Classifier::BayesData.remove_punct(s1)
    @s22 = Trex::Classifier::BayesData.remove_punct(s2)
    @s33 = Trex::Classifier::BayesData.remove_punct(s3)

    assert @s11 == "This  punct  punctuation se punct ntence  punct  punct  punct "
    assert @s22 == "Much  punct  in  punct  this  punct   punct  sentence too punct "
    assert @s33 == "And I punct  have c punct des in  punct his one too punct  punct  punct "
  end

  test "datetimemoney is removed" do
    s1 = "This $140 will be paid on 09/14/2014"
    s2 = "I get $20.00 on 2014-05-21 and on 09MAR04"
    s3 = "I'll pay you $60.21 on 06-20-2014"

    @s11 = Trex::Classifier::BayesData.remove_date_time(s1)
    @s22 = Trex::Classifier::BayesData.remove_date_time(s2)
    @s33 = Trex::Classifier::BayesData.remove_date_time(s3)

    assert @s11 == "This $140 will be paid on  datetimemoney "
    assert @s22 == "I get $20.00 on  datetimemoney  and on  datetimemoney "
    assert @s33 == "I'll pay you $60.21 on  datetimemoney "
  end

  test "index frequency has correct counts" do
    s = "Here is a sentence that that that I need & & ^ % $c#@ to check the index is correct and okay."
    @result = Trex::Classifier::BayesData.index_frequency(s)

    assert @result[:punct] == 8
    assert @result[:that] == 3
    assert @result[:c] == 1
    assert @result[:Here] == 1
    assert @result[:sentenc] == 1
    assert @result[:sentence] == 1

    #{:sentenc=>1, :need=>1, :punct=>8, :check=>1, :index=>1, :correct=>1, :okai=>1, :Here=>1, :is=>2, :a=>1, :sentence=>1, :that=>3, :I=>1, :c=>1, :to=>1, :the=>1, :and=>1, :okay=>1}
  end

end
