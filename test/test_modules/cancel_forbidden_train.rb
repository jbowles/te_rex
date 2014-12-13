module TeRex
  module Train
    CANCELFORBIDDEN = [
      "Internal server error. SERVER_ERROR com.orbitz.tbs.model.txn.PolicyViolationException: Hotel pre-cancel failed for HBRQST8795195244 Too late to cancel reservation CANCELLATION_DEADLINE_PASSED",
      "Internal server error. SERVER_ERROR java.util.concurrent.ExecutionException: java.lang.IllegalArgumentException: productPreCancelInfos cannot be null or empty\\n\\tat java.util.concurrent.FutureTask$Sync.innerGet(FutureTask.java:222)\\n\\tat java.util.concurrent.FutureTask.get(FutureTask.java:83)\\n\\tat com.orbitz.ws.tbs.ReservationServiceSupport.callFutureTask(ReservationServiceSupport.java:313)\\n\\tat com.orbitz.ws.tbs.ReservationServiceSupport.buildPreCancelFutureTaskResponse(ReservationServiceSupport.java:433)\\n\\tat com.orbitz.ws.hotel.cancel.service.HotelCancelServiceImpl.buildMultiRoomCancelResponse(HotelCancelServiceImpl.java:288)\\n\\tat com.orbitz.ws.hotel.cancel.service.HotelCancelServiceImpl.buildHotelCancelResponse(HotelCancelServiceImpl.java:204)\\n\\tat com.orbitz.ws.hotel.cancel.service.HotelCancelServiceImpl.execute(HotelCancelServiceImpl.java:160",
      "RES_CANCELLED",
      "Reservation cannot be cancelled online. Please email reply@travelnow.com and reference your Itinerary Number if you have questions regarding the status of your reservation.",
      "Reservation cannot be cancelled online.",
      "Reservation not cancelable or zero refund",
      "Too late to cancel reservation - deadline date has passed. CANCEL_DATE_PASSED Too late to cancel reservation - deadline date has passed.",
      "Unable to cancel reservation. Please contact customer service.",
      "Unable to cancel reservation. This reservation is pending. Please contact customer service.",
      "Unable to cancel reservation. This reservation was manually booked. Please contact customer service.",
      "Unable to cancel reservation.",
      "Unable to obtain cancellation number. Please contact customer service.",
      "error.ResModifyError: Changes are not allowed",
      "error.blockSpace",
      "error.cancel.orderline.",
      "error.nonRefundableBooking: Reservation is Non-Refundable.",
      "error.orderline.already.canceled",
      "multiple.notSupported"
    ]
  end
end

