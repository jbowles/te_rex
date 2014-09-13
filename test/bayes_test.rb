require_relative "../lib/trex"
class BayesTest < MicroTest::Test
  @@refund = [
    "Free cancellation before 1201 AM on 9/17/14! If you cancel or change your reservation after 1201 AM on 9/17/14 the hotel will charge you for the total cost of your reservation.",
    "ALL RESERVATIONS MUST BE CANCELLED 24 HOURS PRIOR TO HOST TIME UNLESS DEPOSIT REQUIRED IF THIS RESERVATION HAS BEEN MADE ELECTRONICALLY PLEASE CANCEL IT ELECTRONICALLY TO AVOID CONFUSION AND A NO SHOW BILL. POLICY SUBJECT TO CHANGE. .",
    "Free cancellation before 800 PM on 9/20/14! If you cancel or change your reservation after 800 PM on 9/20/14 the hotel will charge you $158. If you cancel or change your reservation after 800 PM on 9/21/14 the hotel will charge you for the total cost of your reservation.",
    "Any cancellation received within 2 days prior to arrival date will incur the first night charge. Failure to arrive at your hotel will be treated as a No-Show and will incur the first night charge (Hotel policy)."
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
    "The cancellation policy will be determined when the rate is validated."
  ]

  @@cls = Trex::Classifier::Bayes.new("Refund", "Nonrefund", "Partrefund", "Unknown")
  @@refund.each {|txt| @@cls.train("Refund", txt) }
  @@partrefund.each {|txt| @@cls.train("Partrefund", txt) }
  @@norefund.each {|txt| @@cls.train("Nonrefund", txt) }
  @@unknown.each {|txt| @@cls.train("Unknown", txt) }

  test "Exact match classifier" do

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
  end


  test "Sparse data set should return unknown" do

    s1 = "You will get a full refund and free cancellation"
    s2 = "You will get a partial refund and be charged"
    s3 = "You will get no refund"
    s4 = "What kind of silly nonsense am I writing here."

    s11 = @@cls.classify(s1)
    s22 = @@cls.classify(s2)
    s33 = @@cls.classify(s3)
    s44 = @@cls.classify(s4)

    assert s11 == "Unknown"
    assert s22 == "Unknown"
    assert s33 == "Unknown"
    assert s44 == "Unknown"
  end

end

