require_relative "../lib/te_rex"
class TrainedBayesProviderErrorsTest < PryTest::Test

  @@avail = TeRex::Train::AVAIL
  @@book = TeRex::Train::BOOK
  @@cancel = TeRex::Train::CANCEL
  @@cancel_forbidden = TeRex::Train::CANCELFORBIDDEN
  @@credit_data = TeRex::Train::CREDITDATA
  @@credit_decline = TeRex::Train::CREDITDECLINE
  @@credit_service = TeRex::Train::CREDITSERVICE
  @@unexpected = TeRex::Train::UNEXPECTED
  #@@unk = TeRex::Train::UNKNOWNERROR

  @@cls = TeRex::Classifier::Bayes.new(
    {:tag => "AvailabilityError",         :msg => "No hotel or room availability for request."},
    {:tag => "BookingError",              :msg => "Error processing Booking Request"},
    {:tag => "CancelError",               :msg => "Check data entry for Cancellation Request"},
    {:tag => "CancelForbiddenError",      :msg => "Cancellation forbidden"},
    {:tag => "CreditDataError",           :msg => "Credit Card data is invalid"},
    {:tag => "CreditDeclineError",        :msg => "Waht? Credit Card declined!"},
    {:tag => "CreditServiceError",        :msg => "External service problem processing"},
    {:tag => "UnexpectedResponseError",   :msg => "Unexpected response"}
    #{:tag => "UnknownError",              :msg => "Unexpected response"},
  )
  @@avail.each {|txt| @@cls.train("AvailabilityError", txt) }
  @@book.each {|txt| @@cls.train("BookingError", txt) }
  @@cancel.each {|txt| @@cls.train("CancelError", txt) }
  @@cancel_forbidden.each {|txt| @@cls.train("CancelForbiddenError", txt) }
  @@credit_data.each {|txt| @@cls.train("CreditDataError", txt) }
  @@credit_decline.each {|txt| @@cls.train("CreditDeclineError", txt) }
  @@credit_service.each {|txt| @@cls.train("CreditServiceError", txt) }
  @@unexpected.each {|txt| @@cls.train("UnexpectedResponseError", txt) }
  #@@unk.each {|txt| @@cls.train("UnknownError", txt) }


  test "Training Data Provider Errors Set Test: Random exact match sould classify correctly" do

    s_avail = @@avail.sample
    s_book = @@book.sample
    s_cancel = @@cancel.sample
    s_cancel_forbidden = @@cancel_forbidden.sample
    s_credit_data = @@credit_data.sample
    s_credit_decline = @@credit_decline.sample
    s_credit_service = @@credit_service.sample
    s_unexpected = @@unexpected.sample

    s_avail1 = @@cls.classify(s_avail)
    s_book1 = @@cls.classify(s_book)
    s_cancel1 = @@cls.classify(s_cancel)
    s_cancel_forbidden1= @@cls.classify(s_cancel_forbidden)
    s_credit_data1 = @@cls.classify(s_credit_data)
    s_credit_decline1 = @@cls.classify(s_credit_decline)
    s_credit_service1 = @@cls.classify(s_credit_service)
    s_unexpected1 = @@cls.classify(s_unexpected)

    assert s_avail1 == ["AvailabilityError", "No hotel or room availability for request."]
    assert s_book1 == ["BookingError", "Error processing Booking Request"]
    assert s_cancel1 == ["CancelError", "Check data entry for Cancellation Request"]
    assert s_cancel_forbidden1 == ["CancelForbiddenError", "Cancellation forbidden"]
    assert s_credit_data1 == ["CreditDataError", "Credit Card data is invalid"] || ["CreditServiceError", "External service problem processing"]
    assert s_credit_decline1 == ["CreditDeclineError", "Waht? Credit Card declined!"]
    assert s_credit_service1 == ["CreditServiceError", "External service problem processing"] || ["CreditDataError", "Credit Card data is invalid"]
    assert s_unexpected1 == ["UnexpectedResponseError", "Unexpected response"]
  end


#  test "Training Data Set Test: cancel-cacancelical examples should classify correctly" do
#
#    avail_s1 = "You will get a full avail and free cancellation"
#    partavail_s1 = "You will get a avail if you cancel or change your reservation before 0201 AM on 01/31/14"
#    noavail_s1 = "You will get a cancel-avail"
#    cancel_forbidden_s1 = "You will get a cancelsense am I writing here."
#
#    avail_s11 = @@cls.classify(avail_s1)
#    partavail_s11 = @@cls.classify(partavail_s1)
#    noavail_s11 = @@cls.classify(noavail_s1)
#    cancel_forbidden_s11 = @@cls.classify(cancel_forbidden_s1)
#
#    assert avail_s11 == ["avail", "We are pleased to offer you a avail"]
#    assert partavail_s11 == ["Partavail", "You may receive a book avail"]
#    assert noavail_s11 == ["cancelavail", "Much apologies, no avail to you"]
#    assert cancel_forbidden_s11 == ["cancel_forbiddennown", "Waht?"]
#  end
#
#  test "Training Data Set Test: Micro examples should return correct classification" do
#
#    s1 = "free cancellation"
#    s2 = "If you cancel or change your reservation before"
#    s3 = "cancel-avail"
#    s4 = "policy rate validated."
#
#    s11 = @@cls.classify(s1)
#    s22 = @@cls.classify(s2)
#    s33 = @@cls.classify(s3)
#    s44 = @@cls.classify(s4)
#
#    assert s11 == ["avail", "We are pleased to offer you a avail"]
#    assert s22 == ["Partavail", "You may receive a book avail"]
#    assert s33 == ["cancelavail", "Much apologies, no avail to you"]
#    assert s44 == ["cancel_forbiddennown", "Waht?"]
#
#    assert s11 != ["Partavail", "You may receive a book avail"]
#    assert s22 != ["cancelavail", "Much apologies, no avail to you"]
#    assert s33 != ["cancel_forbiddennown", "Waht?"]
#    assert s44 != ["avail", "We are pleased to offer you a avail"]
#  end
#
#  test "Training Data Set Test: Micro examples should NOT match fake classes" do
#
#    s1 = "free cancellation"
#    s2 = "book avail"
#    s3 = "no avail"
#    s4 = "policy rate validated."
#
#    s11 = @@cls.classify(s1)
#    s22 = @@cls.classify(s2)
#    s33 = @@cls.classify(s3)
#    s44 = @@cls.classify(s4)
#
#    assert s11 != ["Computers", "computers yay!"]
#    assert s22 != ["Science", "science yay!"]
#    assert s33 != ["Entertainment", "entertainment yay!"]
#    assert s44 != ["Sports", "sports yay!"]
#  end
#
#  test "Training Data Set Test: Ambiguous examples should return 'cancel_forbiddennown'" do
#
#    s1 = "gobbly goop droop blithely toadwakle Grimpleshtein uf Varendorrf vun muscilaty"
#    s2 = "The United States announced on Tuesday it will send 3,000 troops to help tackle the Ebola outbreak as part of a ramped-up plan, including a major deployment in Liberia."
#    s3 = "United Parcel Service Inc is almost doubling the number of seasonal employees it hires for this year's holiday shopping season as it aims to avoid a repeat of last year's network breakdown."
#    s4 = "Alberto Contador wrapped up his third Vuelta a España triumph when he comfortably held on to his overall lead in the 21st and final stage time trial in a rain-soaked Santiago de Compostela on Sunday."
#
#    s11 = @@cls.classify(s1)
#    s22 = @@cls.classify(s2)
#    s33 = @@cls.classify(s3)
#    s44 = @@cls.classify(s4)
#
#    assert s11 == ["cancel_forbiddennown", "Waht?"]
#    assert s22 == ["cancel_forbiddennown", "Waht?"] 
#    assert s33 == ["cancel_forbiddennown", "Waht?"]
#    assert s44 == ["cancel_forbiddennown", "Waht?"]
#  end
#
#  test "Training Data Set Test: Category counts are equivalent with number of training data per class" do
#
#    assert @@cls.category_counts[:avail] == @@avail.count 
#    assert @@cls.category_counts[:Partavail] == @@partavail.count 
#    assert @@cls.category_counts[:cancelavail] == @@noavail.count 
#    assert @@cls.category_counts[:cancel_forbiddennown] == @@cancel_forbiddennown.count 
#
#  end
#
#  test "Sparse Data Set Test: Training categories should NOT be undertrained... except 'cancel_forbiddennown'" do
#    info = @@cls.training_description
#    puts "\nUndertraining data for SPARSE DATA SET: #{info}"
#    res = @@cls.under_trained?
#    assert res[0].include? :cancel_forbiddennown
#  end

end


