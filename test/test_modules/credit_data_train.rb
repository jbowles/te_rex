module TeRex
  module Train
    CREDITDATA = [
      "1\\u0087FORMAT ERROR ON OPTIONAL FIELD NotProcessed BusinessLogic ERR.SWS.HOST.ERROR_IN_RESPONSE",
      "Address category (ex. Home Work etc) is required.",
      "CC account name error.",
      "CC name error.",
      "CSV_FAIL",
      "Credit card error.",
      "Credit card type is invalid",
      "Credit card type not accepted at the property",
      "Do not honor. (Pickup message).",
      "Hotel Booking Error (Card Failure - Processing Problem - Card Problem)",
      "Invalid credit card data was provided. Please review and correct.",
      "PAYMENT_FAILURE",
      "Payment Failure happened",
      "Phone category (ex. Home Work etc) is required.",
      "Please provide a valid Credit card details INVALID_CREDIT_CARD Credit card details contains invalid values",
      "Please provide a valid Credit card details INVALID_CREDIT_CARD com.orbitz.tbs.model.SystemException: Unknown exception caught stack is: com.orbitz.omp.api.model.OmpServiceException: Failed Lapsang Service Invocation. requestURL: http://teakettle.qa1.o.com/omp/payment/validate\\nstatusCode: 500",
      "Please provide a valid Credit card details INVALID_CREDIT_CARD com.orbitz.tbs.model.SystemException: Unknown exception caught stack is: com.orbitz.omp.api.model.OmpServiceException: Failed Lapsang Service Invocation. requestURL: http:\\/\\/amexapp01q.qa.orbitz.net\\/omp\\/payment\\/validate\\nstatusCode: 500\\nstatusMessage: Internal Server Error\\nserver: Apache-Coyote\\/1.1 (caused by com.orbitz.lapsang.http.client.HttpInvocationResponseException: Failed Lapsang Service Invocation. requestURL: http:\\/\\/amexapp01q.qa.orbitz.net\\/omp\\/payment\\/validate\\nstatusCode: 500",
      "Postal Code should be provided for specified country.",
      "State or province required for specified country.",
      "The Card Security Code you entered did not validate for your credit card please correct and resubmit. ",
      "The card type provided is not accepted at this property or the credit card used is not listed in their record. Valid card types for the property are not known until booked when submitting a reservation.	The user must select another card type that will be accepted by the property.",
      "The credit card type is invalid. Please correct this information and try again",
      "The specified credit card expiration date is invalid",
      "The specified credit card expiration date is invalid. Please correct this information and try again",
      "The specified credit card number is invalid. Please check the number you've provided and try again.",
      "This request can not be processed. Please verify if the billing address is correct and try again",
      "This reservation can not be processed. Verify if the number of credit card and expiration date are correct and try again",
      "This reservation can not be processed. Verify if the number of credit card is correct and try again",
      "We're sorry but we were unable to process your request. The card number that you entered may not be correct. Please verify that the card number is correct and try again. errors.resInfo.cc.invalidCardNumber: MSTERR_TRAVCC_INVALID_ACCOUNT: 505",
      "We're sorry our system can not authenticate the information you have provided an information mismatch has occurred please verify your credit card and billing information are correct and try again.",
      "We're sorry our system can not authenticate the information you have provided. An information mismatch has occurred. Please verify your credit card and billing information are correct and try again. errors.resInfo.cc: MSTERR_TRAVCC_DECLINE: 502",
      "We're sorry our system can not authenticate the information you have provided. An information mismatch has occurred. Please verify your credit card and billing information are correct and try again.",
      "We’re sorry but we were unable to process your request. Please verify that the billing address is correct and try again.",
      "We’re sorry but we were unable to process your request. Please verify that the credit card number and expiration date are correct and try again.",
      "We’re sorry but we were unable to process your request. The card number that you entered may not be correct. Please verify that the card number is correct and try again.",
      "We’re sorry but we were unable to process your request. The expiration date that you entered may not be correct. Please verify that the expiration date is correct and try again.	",
      "\\u0087INVALID CARD NUMBER\\u0087 NotProcessed BusinessLogic ERR.SWS.HOST.ERROR_IN_RESPONSE",
      "\\u0087INVLD\\u0087 CREDIT CARD TYPE NOT ACCEPTED BY PROP NotProcessed BusinessLogic ERR.SWS.HOST.ERROR_IN_RESPONSE",
      "\\u0087NR\\u0087 RMS NotProcessed BusinessLogic ERR.SWS.HOST.ERROR_IN_RESPONSE",
      "at com.orbitz.tbs.host.txn.omp.DefaultOmpProcessor.checkFailedAuth(DefaultOmpProcessor.java:182)\\n\\tat com.orbitz.tbs.host.txn.omp.DefaultOmpProcessor.validate(DefaultOmpProcessor.java:67)\\n\\tat com.orbitz.tbs.host.txn.command.book.BaseBookPaymentVerifyCommand.doValidate(BaseBookPaymentVerifyCommand.java:314",
      "at com.orbitz.tbs.host.txn.omp.DefaultOmpProcessor.checkFailedAuth(DefaultOmpProcessor.java:182)\\n\\tat com.orbitz.tbs.host.txn.omp.DefaultOmpProcessor.validate(DefaultOmpProcessor.java:67)\\n\\tat com.orbitz.tbs.host.txn.command.book.BaseBookPaymentVerifyCommand.execute(BaseBookPaymentVerifyCommand.java:215",
      "com.orbitz.tbs.host.txn.omp.DefaultOmpProcessor.checkFailedAuth(DefaultOmpProcessor.java:180)\\n\\tat com.orbitz.tbs.host.txn.omp.DefaultOmpProcessor.validate(DefaultOmpProcessor.java:66)\\n\\tat com.orbitz.tbs.host.txn.command.book.BaseBookPaymentVerifyCommand.doValidate(BaseBookPaymentVerifyCommand.java:296",
      "com.orbitz.tbs.model.txn.PaymentException: Bad Auth. Causing CreditAuthResult:Invalid Account Number",
      "error.addressCategoryCode.value.invalid",
      "error.creditCardDeclined <TNOWERROR_ATTR> <CC_TRANSACTIONSTATUS>  </CC_TRANSACTIONSTATUS> <TRANSACTIONSTATUSMSG> Transaction refused </TRANSACTIONSTATUSMSG> </TNOWERROR_ATTR>",
      "error.creditCardDeclined.invalidBillingAddress:Internal application error.:MessageReferenceId=UnknownMessageReferenceId.Exception=credit card transaction reenter(usually invalid address) by CC clearing house : CommonErrors::MSTError:501",
      "error.creditCardDeclined.invalidExpirationDate: Internal application error.:MessageReferenceId=UnknownMessageReferenceId.Exception=Invalid/missing expiration date : CommonErrors::MSTError:507",
      "error.creditCardDeclined.invalidOrMissingNumber: Internal application error.:MessageReferenceId=UnknownMessageReferenceId. Exception=Invalid/missing credit card number : CommonErrors::MSTError:505",
      "error.creditCardDeclined.invalidPaymentDetails: Internal application error.:MessageReferenceId=UnknownMessageReferenceId.Exception=Error in payment details - creditcard number not OK expiry date in the past etc. : CommonErrors::MSTError:545",
      "error.creditCardDeclined:Internal application error.:MessageReferenceId=UnknownMessageReferenceId. Exception=The credit card number is not valid.:CommonErrors::MSTError:62",
      "error.mismatch.last4digits.creditCard",
      "error.phoneCategoryCode.value.invalid",
      "error.postalCode.required.for.country",
      "error.province.required.forCountry",
      "errors.resInfo.cc.invalidCardNumber",
      "errors.resInfo.cc.invalidExpirationDate",
      "errors.resInfo.cc.invalidPaymentDetails",
      "errors.supplier.csv: MSTERR_TRAVCC_CID_NOT_MATCHED: 529",
      "mystiquebooking"
    ]
  end
end
