require_relative "../lib/te_rex"
class BayesDataTest < MicroTest::Test

  test "punctuation is removed (except %)" do
    s1 = "This * punctuation se%ntence ).!"
    s2 = "Much $ in @ this } [ sentence too?"
    s3 = "And I$ have c#des in |his one with 100% refund too@>."

    s11 = TeRex::Classifier::BayesData.remove_punct(s1)
    s22 = TeRex::Classifier::BayesData.remove_punct(s2)
    s33 = TeRex::Classifier::BayesData.remove_punct(s3)

    assert s11 == "This  punctuation se%ntence "
    assert s22 == "Much  in  this   sentence too"
    assert s33 == "And I have cdes in his one with 100% refund too"
  end

  test "datetime is removed and replaced" do
    s1 = "This $140 will be paid on 09/14/2014"
    s2 = "I get $20.00 on 2014-05-21 and on 09MAR04"
    s3 = "I'll pay you $60.21 on 06-20-2014"

    s11 = TeRex::Classifier::BayesData.date_time(s1)
    s22 = TeRex::Classifier::BayesData.date_time(s2)
    s33 = TeRex::Classifier::BayesData.date_time(s3)

    assert s11 == "This $140 will be paid on datetime"
    assert s22 == "I get $20.00 on datetime and on datetime"
    assert s33 == "I'll pay you $60.21 on datetime"
  end

  test "moneyterm is removed and replaced" do
    s1 = "$140 will be paid on 09/14/2014 with $60"
    s2 = "I get $20.00 on 2014-05-21 and on 09MAR04"
    s3 = "You'll make $1234.73 on 06-20-2014"

    s11 = TeRex::Classifier::BayesData.money_term(s1)
    s22 = TeRex::Classifier::BayesData.money_term(s2)
    s33 = TeRex::Classifier::BayesData.money_term(s3)

    assert s11 == "moneyterm will be paid on 09/14/2014 with moneyterm"
    assert s22 == "I get moneyterm on 2014-05-21 and on 09MAR04"
    assert s33 == "You'll make moneyterm on 06-20-2014"
  end

  test "index frequency has correct counts" do
    s = "Here is a sentence $141.34 that that $60 that 123.56 I need & & ^ % $c#@ to check the index is correct and okay."
    result = TeRex::Classifier::BayesData.index_frequency(s)

    assert result[:moneyterm] == 3
    assert result[:sentenc] == 1
    assert result[:sentence] == 1

  end

end
