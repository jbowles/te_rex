require_relative "../lib/te_rex"
class BayesDataTest < PryTest::Test

  test "punctuation is removed (except %)" do
    s1 = "This * punctuation se%ntence ).!"
    s2 = "Much $ in @ this } [ sentence too?"
    s3 = "And I$ have c#des in |his one with 100% refund too@>."

    s11 = TeRex::Classifier::BayesData.remove_punct(s1)
    s22 = TeRex::Classifier::BayesData.remove_punct(s2)
    s33 = TeRex::Classifier::BayesData.remove_punct(s3)

    assert s11 == "This   punctuation se%ntence    "
    assert s22 == "Much   in   this     sentence too "
    assert s33 == "And I  have c des in  his one with 100% refund too   "
  end

  test "datetime is removed and replaced" do
    s1 = "This $140 will be paid on 09/14/2014"
    s2 = "At on 2015/09/08 get $20.00 on 2014-05-21 and on 09MAR04"
    s3 = "I'll pay you $60.21 on 06-20-2014"

    s11 = TeRex::Classifier::BayesData.date_time(s1)
    s22 = TeRex::Classifier::BayesData.date_time(s2)
    s33 = TeRex::Classifier::BayesData.date_time(s3)

    assert s11 == "This $140 will be paid on datetime"
    assert s22 == "At on datetime get $20.00 on datetime and on datetime"
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

  test "cleaned text does what we want" do
    s1 = "$140 will be paid on 09/14/2014 with $60"
    s2 = "I get $20.00 on 2014-05-21 and on 09MAR04 with %49 and &*%^)"
    s3 = "And I$ have c#des in |his one wi%th 100% refund too@>."

    s11 = TeRex::Classifier::BayesData.clean(s1)
    s22 = TeRex::Classifier::BayesData.clean(s2)
    s33 = TeRex::Classifier::BayesData.clean(s3)

    assert s11 == "moneyterm will be paid on datetime with moneyterm"
    assert s22 == "I get moneyterm on datetime and on datetime with %49 and % "
    assert s33 == "And I have c des in his one wi%th 100% refund too "
  end

  test "check that error codes are not stripped out" do
    h108 = "H108 PROCESS_FAIL 50008 Unable to cancel reservation. An unknown error has occurred. Please call us for more information."
    h109 = "H109 PROCESS_FAIL 50008 Unable to cancel reservation. An unknown error has occurred. Please call us for more information."
    h110 = "H110 PROCESS_FAIL 50008 Unable to cancel reservation. An unknown error has occurred. Please call us for more information."
    h115 = "H115 UNABLE_TO_PROCESS_REQUEST 50010 Unable to obtain cancellation number. Please contact customer service."

    s1 = TeRex::Classifier::BayesData.clean(h108)
    s2 = TeRex::Classifier::BayesData.clean(h109)
    s3 = TeRex::Classifier::BayesData.clean(h110)
    s4 = TeRex::Classifier::BayesData.clean(h115)

    assert s1 == "H108 PROCESS FAIL 50008 Unable to cancel reservation An unknown error has occurred Please call us for more information "
    assert s2 == "H109 PROCESS FAIL 50008 Unable to cancel reservation An unknown error has occurred Please call us for more information "
    assert s3 == "H110 PROCESS FAIL 50008 Unable to cancel reservation An unknown error has occurred Please call us for more information "
    assert s4 == "H115 UNABLE TO PROCESS REQUEST 50010 Unable to obtain cancellation number Please contact customer service "
  end
  test "index frequency has correct counts" do
    s = 'Here is a sentence $141.34 that that $60 that 123.56 I need & & ^ % $c#@ to check the index is correct and okay.'
    result = TeRex::Classifier::BayesData.index_frequency(s)

    assert result[:moneyterm] == 3
    assert result[:sentenc] == 1
    assert result[:sentence] == 1
  end
end
