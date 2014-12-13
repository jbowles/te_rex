module TeRex
  module Train
    CANCEL = [
      "A record was missing in this process. Please contact customer service.",
      "Client not found in system.",
      "Order is currently being processed. Please try again later.",
      "This request has already processed and cancelled.",
      "Please enter the customer's reservation confirmation number.",
      "RES_NOT_FOUND",
      "Requested for product which is already cancelled. CANCELLED_PRODUCT Requested for product which is already cancelled.",
      "Reservation could not be retrieved.",
      "Reservation not found in system.",
      "The hotel confirmation information provided could not be resolved to a valid record this reservation has not been canceled. No HotelConfirmation Number Found. Reservation Not Cancelled.",
      "The room(s) in this hotel reservation are not cancelled : MULTI_ROOM_PARTIAL_CANCELLATION The room(s) in this hotel reservation are not cancelled",
      "This product is currently not available. com.orbitz.tbs.model.SystemException: Hotel preCancel failed com.orbitz.tbs.spi.txn.cancel.SpiProductPreCancelCriteria productType=HotelproductLocatorCode=reservationStartDate=multiCurrencyDetails=\\n\\tat com.orbitz.tbs.hotel.mgr.HotelCancelServiceManager.handleHotelCancelException(HotelCancelServiceManager.java:634)\\n\\tat com.orbitz.tbs.hotel.mgr.HotelCancelServiceManager.preCancelMerchantBooking(HotelCancelServiceManager.java:322)\\n\\tat com.orbitz.tbs.hotel.mgr.HotelCancelServiceManager.preCancel(HotelCancelServiceManager.java:271)\\n\\tat com.orbitz.tbs.hotel.book.svc.HotelSpiReservationServiceImpl.preCancelProduct(HotelSpiReservationServiceImpl.java:913",
      "This product is currently not available. com.orbitz.tbs.model.SystemException: Hotel preCancel failed",
      "This reservation could not be found.",
      "Unable to cancel reservation. Probably your reservation has already processed and cancelled. Please call us for more information.",
      "error.order.currentProcessing.tryLater",
      "error.orderLine.notFound.",
      "error.orderNumber.notFound",
      "for.ordernum.orderguid.passed"
    ]
  end
end
