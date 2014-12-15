module TeRex
  module Train
    CREDITSERVICE = [
      "mystiquebooking",
      "Payment Failure happened. Unsuccessful Payment.",
      "Payment Failure happened. com.orbitz.tbs.model.txn.PaymentException: Bad Auth. Causing CreditAuthResult:Unknown could not identify\\n\\tat com.orbitz.tbs.host.txn.omp.DefaultOmpProcessor.checkFailedAuth(DefaultOmpProcessor.java:180)\\n\\tat com.orbitz.tbs.host.txn.omp.DefaultOmpProcessor.validate(DefaultOmpProcessor.java:66)\\n\\tat com.orbitz.tbs.host.txn.command.book.BaseBookPaymentVerifyCommand.doValidate(BaseBookPaymentVerifyCommand.java:296",
      "Payment Failure happened. com.orbitz.tbs.model.SystemException: Unknown exception caught stack is: com.orbitz.lapsang.http.client.HttpInvocationRequestException: Failed Lapsang Service Invocation. requestURL: http:\\/\\/amexapp01q.qa.orbitz.net\\/omp\\/payment\\/validate\\nrequestMethod: POST\\n\\tat com.orbitz.lapsang.http.client.AbstractHttpInvocationHandler.doObject(AbstractHttpInvocationHandler.java:330)\\n\\tat com.orbitz.lapsang.http.client.AbstractHttpInvocationHandler.invoke(AbstractHttpInvocationHandler.java:186",
      "We're sorry our system can not authenticate the information you have provided. An information mismatch has occurred. Please verify your credit card and billing information are correct and try again.",
      "error.fraud",
      "error.fraud.aegis",
      "error.fraud.aegis.connectionFailure",
      "error.fraud.aegis.timeout",
      "error.fraud.db",
      "error.fraud.invalidRequest",
      "error.fraud.lodging",
      "error.fraud.lodging.connectionFailure",
      "error.fraud.lodging.timeout",
      "error.fraud.payment",
      "error.fraud.payment.connectionFailure",
      "error.fraud.payment.timeout",
      "error.fraud.paymentVault",
      "error.fraud.paymentVault.connectionFailure",
      "error.fraud.paymentVault.timeout",
      "error.fraud.user",
      "error.fraud.user.connectionFailure",
      "error.fraud.user.timeout",
      "error.payment",
      "error.payment.ConnectionFailure",
      "error.payment.PPSTimeout",
      "error.payment.invalidXML",
      "error.paymentVault",
      "error.paymentVaultAccess.unknown.err",
      "error.processFail"
    ]
  end
end
