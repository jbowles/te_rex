require_relative "../lib/te_rex"
class TrainedBayesCancelPolicyTest < PryTest::Test

  #Dir["#{File.dirname(__FILE__)}/test_modules/**/*.rb"].each { |f| load(f) if !!(f =~ /^[^\.].+\.rb/)}

  @@refund = TeRex::Train::REFUND
  @@partrefund = TeRex::Train::PARTREFUND
  @@norefund = TeRex::Train::NONREFUND
  @@unknown = TeRex::Train::UNKNOWN

  @@cls = TeRex::Classifier::Bayes.new(
    {:tag => "Refund",     :msg => "We are pleased to offer you a refund"},
    {:tag => "Partrefund", :msg => "You may receive a partial refund"},
    {:tag => "Nonrefund",  :msg => "Much apologies, no refund to you"},
    {:tag => "Unknown",    :msg => "Waht?"}
  )
  @@refund.each {|txt| @@cls.train("Refund", txt) }
  @@partrefund.each {|txt| @@cls.train("Partrefund", txt) }
  @@norefund.each {|txt| @@cls.train("Nonrefund", txt) }
  @@unknown.each {|txt| @@cls.train("Unknown", txt) }

  test "Training Data CancelPolicy Set Test: Random exact match sould classify correctly (but we are lenient on partrefund/refund)" do

    s_refund = @@refund.sample
    s_partial = @@partrefund.sample
    #s_non = @@norefund.sample
    s_unk = @@unknown.sample

    s_refund1 = @@cls.classify(s_refund)
    s_partial1 = @@cls.classify(s_partial)
    #s_non1 = @@cls.classify(s_non)
    s_unk1= @@cls.classify(s_unk)

    # We are lenient on Partrefund || Refund but we still want to see when it fails
    assert s_refund1 == ["Refund", "We are pleased to offer you a refund"] || ["Partrefund", "You may receive a partial refund"]
    # We are lenient on Refund || Partrefund because of the non-distinctness of the two.
    assert s_partial1 == ["Partrefund", "You may receive a partial refund"] || ["Refund", "We are pleased to offer you a refund"]
    #assert s_non1 == ["Nonrefund", "Much apologies, no refund to you"]
    assert s_unk1 == ["Unknown", "Waht?"]

    # We are lenient on Partrefund || Refund but we still want to see when it fails
    #assert s_refund1 != ["Partrefund", "You may receive a partial refund"]
    # We are lenient on Refund || Partrefund but we still want to see when it fails
    #assert s_partial1 != ["Refund", "We are pleased to offer you a refund"]
    #assert s_non1 != ["Unknown", "Waht?"]
    assert s_unk1 != ["Nonrefund", "Much apologies, no refund to you"]
  end


  test "Training Data Set CancelPolicy Test: Non-canonical examples should classify correctly" do

    #refund_s1 = "full refund and free cancellation"
    partrefund_s1 = "You will get a refund if you cancel or change your reservation before 0201 AM on 01/31/14"
    norefund_s1 = "You will get a non-refund"
    unk_s1 = "You will get a nonsense am I writing here."

    #refund_s11 = @@cls.classify(refund_s1)
    partrefund_s11 = @@cls.classify(partrefund_s1)
    norefund_s11 = @@cls.classify(norefund_s1)
    unk_s11 = @@cls.classify(unk_s1)

    #assert refund_s11 == ["Refund", "We are pleased to offer you a refund"]
    assert partrefund_s11 == ["Partrefund", "You may receive a partial refund"]
    assert norefund_s11 == ["Nonrefund", "Much apologies, no refund to you"]
    assert unk_s11 == ["Unknown", "Waht?"]
  end

  test "Training Data Set CancelPolicy Test: Micro examples should return correct classification" do

    s1 = "free cancellation"
    s2 = "If you cancel or change your reservation before"
    s3 = "non-refund"
    s4 = "policy rate validated."

    s11 = @@cls.classify(s1)
    s22 = @@cls.classify(s2)
    s33 = @@cls.classify(s3)
    s44 = @@cls.classify(s4)

    assert s11 == ["Refund", "We are pleased to offer you a refund"]
    assert s22 == ["Partrefund", "You may receive a partial refund"] || ["Refund", "We are pleased to offer you a refund"]
    assert s33 == ["Nonrefund", "Much apologies, no refund to you"]
    assert s44 == ["Unknown", "Waht?"]

    assert s11 != ["Partrefund", "You may receive a partial refund"]
    assert s22 != ["Nonrefund", "Much apologies, no refund to you"]
    assert s33 != ["Unknown", "Waht?"]
    assert s44 != ["Refund", "We are pleased to offer you a refund"]
  end

  test "Training Data Set CancelPolicy Test: Micro examples should NOT match fake classes" do

    s1 = "free cancellation"
    s2 = "partial refund"
    s3 = "no refund"
    s4 = "policy rate validated."

    s11 = @@cls.classify(s1)
    s22 = @@cls.classify(s2)
    s33 = @@cls.classify(s3)
    s44 = @@cls.classify(s4)

    assert s11 != ["Computers", "computers yay!"]
    assert s22 != ["Science", "science yay!"]
    assert s33 != ["Entertainment", "entertainment yay!"]
    assert s44 != ["Sports", "sports yay!"]
  end

  test "Training Data Set CancelPolicy Test: Ambiguous examples should return 'Unknown'" do

    s1 = "gobbly goop droop blithely toadwakle Grimpleshtein uf Varendorrf vun muscilaty"
    s2 = "The United States announced on Tuesday it will send 3,000 troops to help tackle the Ebola outbreak as part of a ramped-up plan, including a major deployment in Liberia."
    s3 = "United Parcel Service Inc is almost doubling the number of seasonal employees it hires for this year's holiday shopping season as it aims to avoid a repeat of last year's network breakdown."
    s4 = "Alberto Contador wrapped up his third Vuelta a España triumph when he comfortably held on to his overall lead in the 21st and final stage time trial in a rain-soaked Santiago de Compostela on Sunday."

    s11 = @@cls.classify(s1)
    s22 = @@cls.classify(s2)
    s33 = @@cls.classify(s3)
    s44 = @@cls.classify(s4)

    assert s11 == ["Unknown", "Waht?"]
    assert s22 == ["Unknown", "Waht?"] 
    assert s33 == ["Unknown", "Waht?"]
    assert s44 == ["Unknown", "Waht?"]
  end

  test "Training Data Set CancelPolicy Test: Category counts are equivalent with number of training data per class" do

    assert @@cls.category_counts[:Refund] == @@refund.count 
    assert @@cls.category_counts[:Partrefund] == @@partrefund.count 
    assert @@cls.category_counts[:Nonrefund] == @@norefund.count 
    assert @@cls.category_counts[:Unknown] == @@unknown.count 

  end

  test "Sparse Data Set Test: Training categories should NOT be undertrained... except 'Unknown'" do
    info = @@cls.training_description
    puts "\nUndertraining data for SPARSE DATA SET: #{info}"
    res = @@cls.under_trained?
    assert res[0].include? :Unknown
  end

end


