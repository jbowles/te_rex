require_relative "../lib/trex"
class BayesTest < MicroTest::Test
  @@refund = ["refundable", "full refund", "free cancellation", "free cancel", "free", "free", "free", "free", "Free cancellation before 1201 AM on 9/17/14! If you cancel or change your reservation after 1201 AM on 9/17/14 the hotel will charge you for the total cost of your reservation.", "ALL RESERVATIONS MUST BE CANCELLED 24 HOURS PRIOR TO HOST TIME UNLESS DEPOSIT REQUIRED IF THIS RESERVATION HAS BEEN MADE ELECTRONICALLY PLEASE CANCEL IT ELECTRONICALLY TO AVOID CONFUSION AND A NO SHOW BILL. POLICY SUBJECT TO CHANGE. .", "Free cancellation before 800 PM on 9/20/14! If you cancel or change your reservation after 800 PM on 9/20/14 the hotel will charge you $158. If you cancel or change your reservation after 800 PM on 9/21/14 the hotel will charge you for the total cost of your reservation.", "Any cancellation received within 2 days prior to arrival date will incur the first night charge. Failure to arrive at your hotel will be treated as a No-Show and will incur the first night charge (Hotel policy).", "For the room type you've selected you can cancel your reservation for a full refund up until noon on Friday September 12th (local hotel time). If you decide to cancel your reservation anytime between noon on Friday September 12th and noon on Saturday September 13th (local hotel time) the hotel requires payment for the first night's stay. You will be charged for the first night's stay including taxes and fees. Any remaining amount will be refunded to you. Refunds or cancellations are not available after noon local hotel time on your day of arrival (Saturday September 13th).", "THIS PROPERTY REQUIRES A NOTIFICATION OF CANCELLATION BY 4PM HOTEL TIME 1 DAY PRIOR TO ARRIVAL TO AVOID A PENALTY.", "You can cancel free of charge up until the cancellation window. Cancellations or changes made after 4:00 PM Eastern Time on Sep 12, 2014 are subject to a 1 Night Room & Tax penalty. The property makes no refunds for no shows or early checkouts.", "For the room type you've selected you can cancel your reservation for a full refund up until noon on Monday September 15th (local hotel time). If you decide to cancel your reservation anytime between noon on Monday September 15th and noon on Wednesday September 17th (local hotel time) the hotel requires payment for the first night's stay. You will be charged for the first night's stay including taxes and fees. Any remaining amount will be refunded to you. Refunds or cancellations are not available after noon local hotel time on your day of arrival (Wednesday September 17th)."]

  @@partrefund = ["partial", "partial refund", "If you cancel or change your reservation before 1201 AM on 10/21/14 the hotel will charge you $57. If you cancel or change your reservation after 1201 AM on 10/21/14 the hotel will charge you $335. If you cancel or change your reservation after 1201 AM on 10/24/14 the hotel will charge you for the total cost of your reservation.", "If you cancel or change your reservation before 1201 AM on 9/10/14 the hotel will charge you $225. If you cancel or change your reservation after 1201 AM on 9/10/14 the hotel will charge you for the total cost of your reservation.", "Cancellations or changes made before 4:00 PM Eastern Time on Sep 11, 2014 are subject to a 1 Night Room & Tax penalty. Cancellations or changes made after 4:00 PM Eastern Time on Sep 11, 2014 are subject to a 1 Night Room & Tax penalty. The property makes no refunds for no shows or early checkouts."]

  @@norefund = ["non-refundable", "no refund", "This reservation is non-refundable. Cancellations or changes made at any time are subject to a 100% charge.", "This rate is non-refundable and cannot be changed or cancelled - if you do choose to change or cancel this booking you will not be refunded any of the payment.", "For the room type and rate that you've selected you are not allowed to change or cancel your reservation. If you cancel your room you will still be charged for the full reservation amount."]

  @@unknown = ["The cancellation policy will be determined when the rate is validated."]

  @@cls = Trex::Classifier::Bayes.new("Refund", "Nonrefund", "Partrefund", "Unknown")
  #@@refund.each {|txt| @@cls.train("Refund", txt) }
  #@@partrefund.each {|txt| @@cls.train("Nonrefund", txt) }
  #@@norefund.each {|txt| @@cls.train("Partrefund", txt) }
  #@@unknown.each {|txt| @@cls.train("Unknown", txt) }

  @@cls.train("Refund", @@refund.join(', '))
  @@cls.train("Partrefund", @@partrefund.join(', '))
  @@cls.train("Nonrefund", @@norefund.join(', '))
  @@cls.train("Unknown", @@unknown.join(', '))


  test "Exact match classifier" do

    #s1 = "- 1800 HOTEL TIME DAY OF ARRIVAL TO AVOID BILLING OF 1NT ROOM AND TAX OR FORFEITURE OF DEPOSIT "
    s1 = "Free cancellation before 1201 AM on 9/17/14! If you cancel or change your reservation after 1201 AM on 9/17/14 the hotel will charge you for the total cost of your reservation."
    s2 = "If you cancel or change your reservation before 1201 AM on 10/21/14 the hotel will charge you $57. If you cancel or change your reservation after 1201 AM on 10/21/14 the hotel will charge you $335. If you cancel or change your reservation after 1201 AM on 10/24/14 the hotel will charge you for the total cost of your reservation."
    s3 = "This reservation is non-refundable. Cancellations or changes made at any time are subject to a 100% charge."
    s4 = "The cancellation policy will be determined when the rate is validated."

    s11 = @@cls.classify(s1)
    s22 = @@cls.classify(s2)
    s33 = @@cls.classify(s3)
    s44 = @@cls.classify(s4)

    assert s11 == "Refund"
    assert s22 == "Partrefund"
    assert s33 == "Nonrefund"
    assert s44 == "Unknown"
  end


  test "Medium difficult classifier should all be unknown" do

    s1 = "You will get a full refund free cancellation"
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

