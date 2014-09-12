require_relative "../lib/trex"
class BayesDataTest < MicroTest::Test

  test "punctuation is removed" do
    s1 = "This * punctuation se%ntence ).!"
    s2 = "Much $ in @ this } [ sentence too?"
    s3 = "And I$ have c#des in |his one too@>."

    s11 = Trex::Classifier::BayesData.remove_punct(s1)
    s22 = Trex::Classifier::BayesData.remove_punct(s2)
    s33 = Trex::Classifier::BayesData.remove_punct(s3)

    assert s11 == "This  punctuation sentence "
    assert s22 == "Much  in  this   sentence too"
    assert s33 == "And I have cdes in his one too"
  end

  test "datetime is removed and replaced" do
    s1 = "This $140 will be paid on 09/14/2014"
    s2 = "I get $20.00 on 2014-05-21 and on 09MAR04"
    s3 = "I'll pay you $60.21 on 06-20-2014"

    s11 = Trex::Classifier::BayesData.remove_date_time(s1)
    s22 = Trex::Classifier::BayesData.remove_date_time(s2)
    s33 = Trex::Classifier::BayesData.remove_date_time(s3)

    assert s11 == "This $140 will be paid on datetime"
    assert s22 == "I get $20.00 on datetime and on datetime"
    assert s33 == "I'll pay you $60.21 on datetime"
  end

  test "moneyterm is removed and replaced" do
    s1 = "$140 will be paid on 09/14/2014 with $60"
    s2 = "I get $20.00 on 2014-05-21 and on 09MAR04"
    s3 = "You'll make $1234.73 on 06-20-2014"

    s11 = Trex::Classifier::BayesData.money_term(s1)
    s22 = Trex::Classifier::BayesData.money_term(s2)
    s33 = Trex::Classifier::BayesData.money_term(s3)

    assert s11 == "moneyterm will be paid on 09/14/2014 with moneyterm"
    assert s22 == "I get moneyterm on 2014-05-21 and on 09MAR04"
    assert s33 == "You'll make moneyterm on 06-20-2014"
  end

  test "index frequency has correct counts" do
    s = "Here is a sentence $141.34 that that $60 that 123.56 I need & & ^ % $c#@ to check the index is correct and okay."
    result = Trex::Classifier::BayesData.index_frequency(s)

    #assert result[:moneyterm] == 3
    assert result[:that] == 3
    assert result[:c] == 1
    assert result[:Here] == 1
    assert result[:sentenc] == 1
    assert result[:sentence] == 1

    #{:sentenc=>1,:need=>1,:check=>1, :index=>1, :correct=>1, :okai=>1, :Here=>1, :is=>2, :a=>1, :sentence=>1, :that=>3, :I=>1, :c=>1, :to=>1, :the=>1, :and=>1, :okay=>1}
  end

end
