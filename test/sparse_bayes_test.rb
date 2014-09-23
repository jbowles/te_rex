require_relative "../lib/trex"
class SparseBayesTest < MicroTest::Test
  @@refund = [
    "Free cancellation before 1201 AM on 9/17/14! If you cancel or change your reservation after 1201 AM on 9/17/14 the hotel will charge you for the total cost of your reservation.",
    "ALL RESERVATIONS MUST BE CANCELLED 24 HOURS PRIOR TO HOST TIME UNLESS DEPOSIT REQUIRED IF THIS RESERVATION HAS BEEN MADE ELECTRONICALLY PLEASE CANCEL IT ELECTRONICALLY TO AVOID CONFUSION AND A NO SHOW BILL. POLICY SUBJECT TO CHANGE. .",
    "Free cancellation before 800 PM on 9/20/14! If you cancel or change your reservation after 800 PM on 9/20/14 the hotel will charge you $158. If you cancel or change your reservation after 800 PM on 9/21/14 the hotel will charge you for the total cost of your reservation."
  ]

  @@partrefund = [
    "If you cancel or change your reservation before 1201 AM on 10/21/14 the hotel will charge you $57. If you cancel or change your reservation after 1201 AM on 10/21/14 the hotel will charge you $335. If you cancel or change your reservation after 1201 AM on 10/24/14 the hotel will charge you for the total cost of your reservation.",
    "If you cancel or change your reservation before 1201 AM on 9/10/14 the hotel will charge you $225. If you cancel or change your reservation after 1201 AM on 9/10/14 the hotel will charge you for the total cost of your reservation.",
    "Cancellations or changes made before 4:00 PM Eastern Time on Sep 11, 2014 are subject to a 1 Night Room & Tax penalty. Cancellations or changes made after 4:00 PM Eastern Time on Sep 11, 2014 are subject to a 1 Night Room & Tax penalty. The property makes no refunds for no shows or early checkouts."
  ]

  @@norefund = [
    "This reservation is non-refundable. Cancellations or changes made at any time are subject to a 100% charge.",
    "This rate is non-refundable and cannot be changed or cancelled - if you do choose to change or cancel this booking you will not be refunded any of the payment.",
    "For the room type and rate that you've selected you are not allowed to change or cancel your reservation. If you cancel your room you will still be charged for the full reservation amount."
  ]

  @@unknown = [
    "The cancellation policy will be determined when the rate is validated.",
    "unknown"
  ]

  @@cls = Trex::Classifier::Bayes.new("Refund", "Partrefund", "Nonrefund", "Unknown")
  @@refund.each {|txt| @@cls.train("Refund", txt) }
  @@partrefund.each {|txt| @@cls.train("Partrefund", txt) }
  @@norefund.each {|txt| @@cls.train("Nonrefund", txt) }
  @@unknown.each {|txt| @@cls.train("Unknown", txt) }

  test "Sparse Data Set Test: Random exact match sould classify correctly" do

    s_refund = @@refund.sample
    s_partial = @@partrefund.sample
    s_non = @@norefund.sample
    s_unk = @@unknown.sample

    s_refund1 = @@cls.classify(s_refund)
    s_partial1 = @@cls.classify(s_partial)
    s_non1 = @@cls.classify(s_non)
    s_unk1= @@cls.classify(s_unk)

    assert s_refund1 == "Refund"
    assert s_partial1 == "Partrefund"
    assert s_non1 == "Nonrefund"
    assert s_unk1 == "Unknown"

    assert s_refund1 != "Partrefund"
    assert s_partial1 != "Refund"
    assert s_non1 != "Unknown"
    assert s_unk1 != "Nonrefund"
  end


  test "Sparse Data Set Test: Non-canonical examples should return unknown" do

    s1 = "You will get a full refund and free cancellation"
    s2 = "You will get a partial refund and be charged"
    s3 = "You will get non refund"
    s4 = "You will get a nonsense am I writing here."

    s11 = @@cls.classify(s1)
    s22 = @@cls.classify(s2)
    s33 = @@cls.classify(s3)
    s44 = @@cls.classify(s4)

    assert s11 == "Unknown"
    assert s22 == "Unknown"
    assert s33 == "Unknown"
    assert s44 == "Unknown"
  end

  test "Sparse Data Set Test: Micro examples should return correct classification" do

    s1 = "Free cancellation before"
    s2 = "If you cancel or change your reservation before"
    s3 = "nonrefund"
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


test "Sparse Data Set Test: Micro examples should NOT match fake classes" do

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

test "Sparse Data Set Test: Category counts are equivalent with number of training data per class" do

    assert @@cls.category_counts[:Refund] == @@refund.count 
    assert @@cls.category_counts[:Partrefund] == @@partrefund.count 
    assert @@cls.category_counts[:Nonrefund] == @@norefund.count 
    assert @@cls.category_counts[:Unknown] == @@unknown.count 

end

test "Sparse Data Set Test: All SPARSE Training classes should be undertrained... " do
  res = @@cls.under_trained?
  assert res.count == 4
end

end

