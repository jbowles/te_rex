require_relative "../lib/trex"
class TrainedBayesTest < MicroTest::Test

  @@refund = Trex::Train::REFUND
  @@partrefund = Trex::Train::PARTREFUND
  @@norefund = Trex::Train::NONREFUND
  @@unknown = Trex::Train::UNKNOWN

  @@cls = Trex::Classifier::Bayes.new("Refund", "Partrefund", "Nonrefund", "Unknown")
  @@refund.each {|txt| @@cls.train("Refund", txt) }
  @@partrefund.each {|txt| @@cls.train("Partrefund", txt) }
  @@norefund.each {|txt| @@cls.train("Nonrefund", txt) }
  @@unknown.each {|txt| @@cls.train("Unknown", txt) }

  test "Training Data Set Test: Random exact match sould classify correctly (but we are lenient on partrefund/refund)" do

    s_refund = @@refund.sample
    s_partial = @@partrefund.sample
    s_non = @@norefund.sample
    s_unk = @@unknown.sample

    s_refund1 = @@cls.classify(s_refund)
    s_partial1 = @@cls.classify(s_partial)
    s_non1 = @@cls.classify(s_non)
    s_unk1= @@cls.classify(s_unk)

    # We are lenient on Refund || Partrefund because of the non-distinctness of the two.
    assert s_refund1 == "Refund" || "Partrefund"
    assert s_partial1 == "Partrefund" || "Refund"
    assert s_non1 == "Nonrefund"
    assert s_unk1 == "Unknown"

    # We are lenient on Refund || Partrefund but we still want to see when it fails
    assert s_refund1 != "Partrefund"
    assert s_partial1 != "Refund"
    assert s_non1 != "Unknown"
    assert s_unk1 != "Nonrefund"
  end


  test "Training Data Set Test: Non-canonical examples should classify correctly" do

    refund_s1 = "You will get a full refund and free cancellation"
    partrefund_s1 = "You will get a refund if you cancel or change your reservation before 0201 AM on 01/31/14"
    norefund_s1 = "You will get a nonrefund"
    unk_s1 = "You will get a nonsense am I writing here."

    refund_s11 = @@cls.classify(refund_s1)
    partrefund_s11 = @@cls.classify(partrefund_s1)
    norefund_s11 = @@cls.classify(norefund_s1)
    unk_s11 = @@cls.classify(unk_s1)

    assert refund_s11 == "Refund"
    assert partrefund_s11 == "Partrefund"
    assert norefund_s11 == "Nonrefund"
    assert unk_s11 == "Unknown"
  end

  test "Training Data Set Test: Micro examples should return correct classification" do

    s1 = "free cancellation"
    s2 = "If you cancel or change your reservation before"
    s3 = "non-refund"
    s4 = "policy rate validated."

    s11 = @@cls.classify(s1)
    s22 = @@cls.classify(s2)
    s33 = @@cls.classify(s3)
    s44 = @@cls.classify(s4)

    assert s11 == "Refund"
    assert s22 == "Partrefund"
    assert s33 == "Nonrefund"
    assert s44 == "Unknown"

    assert s11 != "Partrefund"
    assert s22 != "Refund"
    assert s33 != "Unknown"
    assert s44 != "Nonrefund"
  end

  test "Training Data Set Test: Micro examples should NOT match fake classes" do

    s1 = "free cancellation"
    s2 = "partial refund"
    s3 = "no refund"
    s4 = "policy rate validated."

    s11 = @@cls.classify(s1)
    s22 = @@cls.classify(s2)
    s33 = @@cls.classify(s3)
    s44 = @@cls.classify(s4)

    assert s11 != "Computers"
    assert s22 != "Science"
    assert s33 != "Entertainment"
    assert s44 != "Sports"
  end

  test "Training Data Set Test: Ambiguous examples should return 'Unknown'" do

    s1 = "gobbly goop droop blithely toadwakle Grimpleshtein uf Varendorrf vun muscilaty"
    s2 = "The United States announced on Tuesday it will send 3,000 troops to help tackle the Ebola outbreak as part of a ramped-up plan, including a major deployment in Liberia."
    s3 = "United Parcel Service Inc is almost doubling the number of seasonal employees it hires for this year's holiday shopping season as it aims to avoid a repeat of last year's network breakdown."
    s4 = "Alberto Contador wrapped up his third Vuelta a España triumph when he comfortably held on to his overall lead in the 21st and final stage time trial in a rain-soaked Santiago de Compostela on Sunday."

    s11 = @@cls.classify(s1)
    s22 = @@cls.classify(s2)
    s33 = @@cls.classify(s3)
    s44 = @@cls.classify(s4)

    assert s11 == "Unknown"
    assert s22 == "Unknown"
    assert s33 == "Unknown"
    assert s44 == "Unknown"
  end

  test "Training Data Set Test: Category counts are equivalent with number of training data per class" do

    assert @@cls.category_counts[:Refund] == @@refund.count 
    assert @@cls.category_counts[:Partrefund] == @@partrefund.count 
    assert @@cls.category_counts[:Nonrefund] == @@norefund.count 
    assert @@cls.category_counts[:Unknown] == @@unknown.count 

  end

  test "Sparse Data Set Test: Training categories should NOT be undertrained... except 'Unknown'" do
    res = @@cls.under_trained?
    assert res[0].include? :Unknown
  end

end


