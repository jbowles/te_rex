require_relative "../lib/trex"
class BayesTest < MicroTest::Test
  @@refund = ["refundable", "full refund", "- 1800 HOTEL TIME DAY OF ARRIVAL TO AVOID BILLING OF 1NT ROOM AND TAX OR FORFEITURE OF DEPOSIT "]

  @@partrefund = ["partial", "partial refund", "If you cancel or change your reservation before 6:00 PM on 9/11/14, the hotel will charge you $159. If you cancel or change your reservation after 6:00 PM on 9/11/14, the hotel will charge you for the total cost of your reservation."]

  @@norefund = ["non-refundable", "no refund", "This rate is non-refundable and cannot be changed or cancelled - if you do choose to change or cancel this booking you will not be refunded any of the payment."]

  @@unknown = ["Got some funky gobbly gook brown foxes and silly nonsense"]

  test "Exact match classifier" do

    cls = Trex::Classifier::Bayes.new("Refund", "Nonrefund", "Partrefund", "Unknown")

    cls.train("Refund", @@refund.join(', '))
    cls.train("Partrefund", @@partrefund.join(', '))
    cls.train("Nonrefund", @@norefund.join(', '))
    cls.train("Unknown", @@unknown.join(', '))

    s1 = "- 1800 HOTEL TIME DAY OF ARRIVAL TO AVOID BILLING OF 1NT ROOM AND TAX OR FORFEITURE OF DEPOSIT "
    s2 = "If you cancel or change your reservation before 6:00 PM on 9/11/14, the hotel will charge you $159. If you cancel or change your reservation after 6:00 PM on 9/11/14, the hotel will charge you for the total cost of your reservation."
    s3 = "This rate is non-refundable and cannot be changed or cancelled - if you do choose to change or cancel this booking you will not be refunded any of the payment."
    s4 = "Gobbly gook bloppy blup duppy dup quick brown foxes jump over the funce"

    s11 = cls.classify(s1)
    s22 = cls.classify(s2)
    s33 = cls.classify(s3)
    s44 = cls.classify(s4)

    assert s11 == "Refund"
    assert s22 == "Partrefund"
    assert s33 == "Nonrefund"
    assert s44 == "Unknown"
  end


  test "Medium difficult classifier" do

    cls = Trex::Classifier::Bayes.new("Refund", "Nonrefund", "Partrefund", "Unknown")

    cls.train("Refund", @@refund.join(', '))
    cls.train("Partrefund", @@partrefund.join(', '))
    cls.train("Nonrefund", @@norefund.join(', '))
    cls.train("Unknown", @@unknown.join(', '))

    s1 = "You will get a full refund"
    s2 = "You will get a partial refund"
    s3 = "You will get no refund"
    s4 = "What kind of silly nonsense am I writing here."

    s11 = cls.classify(s1)
    s22 = cls.classify(s2)
    s33 = cls.classify(s3)
    s44 = cls.classify(s4)

    assert s11 == "Refund"
    assert s22 == "Partrefund"
    assert s33 == "Nonrefund"
    assert s44 == "Unknown"
  end

end

