
require_relative "../lib/trex"
class TrainedBayesTest < MicroTest::Test


  @@refund = Trex::Train::REFUND_TRAIN
  @@partrefund = Trex::Train::PARTREFUND_TRAIN
  @@norefund = Trex::Train::NONREFUND_TRAIN
  @@unknown = Trex::Train::UNKNOWN_TRAIN

  @@cls = Trex::Classifier::Bayes.new("Refund", "Partrefund", "Nonrefund", "Unknown")
  @@refund.each {|txt| @@cls.train("Refund", txt) }
  @@partrefund.each {|txt| @@cls.train("Partrefund", txt) }
  @@norefund.each {|txt| @@cls.train("Nonrefund", txt) }
  @@unknown.each {|txt| @@cls.train("Unknown", txt) }

  test "Sparse Data Set Test: Exact match sould classify correctly" do

    s1 = "Free cancellation before 1201 AM on 9/17/14! If you cancel or change your reservation after 1201 AM on 9/17/14 the hotel will charge you for the total cost of your reservation."
    s2 = "Cancellations or changes made before 4:00 PM Eastern Time on Sep 11, 2014 are subject to a 1 Night Room & Tax penalty."
    s3 = "This reservation is non-refundable. Cancellations or changes made at any time are subject to a 100% charge."
    s4 = "will be determined"

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


  test "Training Data Set Test: Non-canonical examples should return unknown" do

    s1 = "You will get a full refund and free cancellation"
    s2 = "You will get a partial refund and be charged"
    s3 = "You will get a no refund"
    s4 = "You will get a nonsense am I writing here."

    s11 = @@cls.classify(s1)
    s22 = @@cls.classify(s2)
    s33 = @@cls.classify(s3)
    s44 = @@cls.classify(s4)

    assert s11 == "Unknown" #"Nonrefund"
    assert s22 == "Unknown" #"Nonrefund"
    assert s33 == "Unknown" #"Nonrefund"
    assert s44 == "Unknown" #"Nonrefund"
  end

  test "Training Data Set Test: Micro examples should return correct classification" do

    s1 = "free cancellation"
    s2 = "changes made before"
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

test "Training Data Set Test: Category counts are equivalent with number of training data per class" do

    assert @@cls.category_counts[:Refund] == @@refund.count 
    assert @@cls.category_counts[:Partrefund] == @@partrefund.count 
    assert @@cls.category_counts[:Nonrefund] == @@norefund.count 
    assert @@cls.category_counts[:Unknown] == @@unknown.count 

end

test "Sparse Data Set Test: Training classes should NOT be undertrained... except 'Unknown'" do
  res = @@cls.under_trained?
  assert res[0].include? :Unknown
end

end


