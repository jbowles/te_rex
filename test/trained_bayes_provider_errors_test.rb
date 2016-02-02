require_relative "../lib/te_rex"
class TrainedBayesProviderErrorsTest < PryTest::Test

  @@avail = TeRex::Train::AVAIL
  @@book = TeRex::Train::BOOK
  @@cancel = TeRex::Train::CANCEL
  @@cancel_forbidden = TeRex::Train::CANCELFORBIDDEN
  @@credit_data = TeRex::Train::CREDITDATA
  @@credit_decline = TeRex::Train::CREDITDECLINE
  @@credit_service = TeRex::Train::CREDITSERVICE
  #@@unexpected = TeRex::Train::UNEXPECTED
  #@@unk = TeRex::Train::UNKNOWNERROR

  @@cls = TeRex::Classifier::Bayes.new(
    {:tag => "AvailabilityError",         :msg => "No hotel or room availability for request."},
    {:tag => "BookingError",              :msg => "Error processing Booking Request"},
    {:tag => "CancelError",               :msg => "Check data entry for Cancellation Request"},
    {:tag => "CancelForbiddenError",      :msg => "Cancellation forbidden"},
    {:tag => "CreditDataError",           :msg => "Credit Card data is invalid"},
    {:tag => "CreditDeclineError",        :msg => "Waht? Credit Card declined!"},
    {:tag => "CreditServiceError",        :msg => "External service problem processing"},
    #{:tag => "UnexpectedResponseError",   :msg => "Unexpected response"}
    #{:tag => "UnknownError",              :msg => "Unexpected response"},
  )
  @@avail.each {|txt| @@cls.train("AvailabilityError", txt) }
  @@book.each {|txt| @@cls.train("BookingError", txt) }
  @@cancel.each {|txt| @@cls.train("CancelError", txt) }
  @@cancel_forbidden.each {|txt| @@cls.train("CancelForbiddenError", txt) }
  @@credit_data.each {|txt| @@cls.train("CreditDataError", txt) }
  @@credit_decline.each {|txt| @@cls.train("CreditDeclineError", txt) }
  @@credit_service.each {|txt| @@cls.train("CreditServiceError", txt) }
  #@@unexpected.each {|txt| @@cls.train("UnexpectedResponseError", txt) }
  #@@unk.each {|txt| @@cls.train("UnknownError", txt) }


  # pretty liberal about classifying her because the data sets are small and a bit ambigious
  test "Training Data Provider Errors Set Test: Random exact match sould classify correctly" do
    s_avail = @@avail.sample
    s_book = @@book.sample
    s_cancel = @@cancel.sample
    s_cancel_forbidden = @@cancel_forbidden.sample
    s_credit_data = @@credit_data.sample
    s_credit_decline = @@credit_decline.sample
    s_credit_service = @@credit_service.sample
    #s_unexpected = @@unexpected.sample

    s_avail1 = @@cls.classify(s_avail)
    s_book1 = @@cls.classify(s_book)
    s_cancel1 = @@cls.classify(s_cancel)
    s_cancel_forbidden1= @@cls.classify(s_cancel_forbidden)
    s_credit_data1 = @@cls.classify(s_credit_data)
    s_credit_decline1 = @@cls.classify(s_credit_decline)
    s_credit_service1 = @@cls.classify(s_credit_service)
    #s_unexpected1 = @@cls.classify(s_unexpected)

    assert s_avail1 == ["AvailabilityError", "No hotel or room availability for request."] || ["BookingError", "Error processing Booking Request"]
    assert s_book1 == ["BookingError", "Error processing Booking Request"] || ["AvailabilityError", "No hotel or room availability for request."]
    assert s_cancel1 == ["CancelError", "Check data entry for Cancellation Request"] || ["CancelForbiddenError", "Cancellation forbidden"]
    assert s_cancel_forbidden1 == ["CancelForbiddenError", "Cancellation forbidden"] || ["CancelError", "Check data entry for Cancellation Request"]
    assert s_credit_data1 == ["CreditDataError", "Credit Card data is invalid"] || ["CreditServiceError", "External service problem processing"]
    assert s_credit_decline1 == ["CreditDeclineError", "Waht? Credit Card declined!"] || ["CreditDataError", "Credit Card data is invalid"]
    assert s_credit_service1 == ["CreditServiceError", "External service problem processing"] || ["CreditDataError", "Credit Card data is invalid"]
    #assert s_unexpected1 == ["UnexpectedResponseError", "Unexpected response"]
  end

  #test "total word counts correct" do
  #  assert @@cls.total_words == 5696
  #end

  test "text summarization should work" do
    res = @@cls.classify_and_summarize("com. travelnow. supplier. hotel. merchant. translator. Translator Exception: Rate Detail Service threw an exception. Query ID was and PropID:")
    assert res == "this"
  end
end


