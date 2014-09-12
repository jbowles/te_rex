require_relative "../lib/trex"
class BayesTest < MicroTest::Test
  @@refund = ["refundable", "full refund", "- 1800 HOTEL TIME DAY OF ARRIVAL TO AVOID BILLING OF 1NT ROOM AND TAX OR FORFEITURE OF DEPOSIT "]

  @@partrefund = ["partial", "partial refund", "If you cancel or change your reservation before 6:00 PM on 9/11/14, the hotel will charge you $159. If you cancel or change your reservation after 6:00 PM on 9/11/14, the hotel will charge you for the total cost of your reservation."]

  @@norefund = ["non-refundable", "no refund", "This rate is non-refundable and cannot be changed or cancelled - if you do choose to change or cancel this booking you will not be refunded any of the payment."]

  test "Exact match classifier" do

    @cls = Trex::Classifier::Bayes.new("Refund", "Nonrefund", "Partrefund")

    @cls.train("Refund", @@refund.join(', '))
    @cls.train("Partrefund", @@partrefund.join(', '))
    @cls.train("Nonrefund", @@norefund.join(', '))

    s1 = "- 1800 HOTEL TIME DAY OF ARRIVAL TO AVOID BILLING OF 1NT ROOM AND TAX OR FORFEITURE OF DEPOSIT "
    s2 = "If you cancel or change your reservation before 6:00 PM on 9/11/14, the hotel will charge you $159. If you cancel or change your reservation after 6:00 PM on 9/11/14, the hotel will charge you for the total cost of your reservation."
    s3 = "This rate is non-refundable and cannot be changed or cancelled - if you do choose to change or cancel this booking you will not be refunded any of the payment."

    @s11 = @cls.classify(s1)
    @s22 = @cls.classify(s2)
    @s33 = @cls.classify(s3)

    assert @s11 == "Refund"
    assert @s22 == "Partrefund"
    assert @s33 == "Nonrefund"
  end


  test "Medium difficult classifier" do

    @cls = Trex::Classifier::Bayes.new("Refund", "Nonrefund", "Partrefund")

    @cls.train("Refund", @@refund.join(', '))
    @cls.train("Partrefund", @@partrefund.join(', '))
    @cls.train("Nonrefund", @@norefund.join(', '))

    s1 = "You will get a full refund"
    s2 = "You will get a partial refund"
    s3 = "You will get no refund"

    @s11 = @cls.classify(s1)
    @s22 = @cls.classify(s2)
    @s33 = @cls.classify(s3)

    assert @s11 == "Refund"
    assert @s22 == "Partrefund"
    assert @s33 == "Nonrefund"
  end

end

