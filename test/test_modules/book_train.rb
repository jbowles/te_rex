module TeRex
  module Train
    BOOK = [
      "AGENT_ATTENTION Reservation Requires Agent to Confirm Agent waiting on supplier for confirmation number",
      "ALREADY_BOOKED",
      "Agent waiting on supplier for confirmation number",
      "Alternate phone must be numeric and include area code",
      "Data in this request could not be validated: A valid first and last name of one adult guest must be specified for each room",
      "Data in this request could not be validated: Last name contains invalid (or insufficient) data",
      "Data in this request could not be validated: The specified email address cannot be resolved please try again.",
      "Data in this request could not be validated: first name contains invalid (or insufficient) data.",
      "Additional Agent Attention Is Required For This Reservation",
      "Date format does not exist",
      "Duplicate reservation request.",
      "Failure Validate Booking:",
      "Final Reservation Price Check failed before booking QuoteKey",
      "Final Reservation Price Check failed before booking. (Rate Requested: 133.3(USD)) (New Rate: 143.4(USD)). Please try again with new rate.",
      "Home phone must be numeric and include area code",
      "Hotel Booking Error Booked rate exceeds quoted rate Booking error Property Error Booking error",
      "Hotel Booking Error Booking error",
       "Error unmarshaling the request using Fast Info Set.: com. expedia. e3.es.legacy booking. service.Legacy Booking Exceptions:2<TNOWERROR_ATTR> <SUPPLIER _ERROR_ CODE> com. expedia. e3.es.legacy booking. service. Legacy Booking Exceptions:2 </SUPPLIER _ERROR_ CODE> </TNOWERROR_ATTR>",
       "Timeout exception occurred and RollbackOnTimeout = true. Order will be rolled back: 6994 The booking attempt timed out. Attempt the booking again if you receive this error.",
      "Hotel Booking Error Rate not available",
      "Hotel Booking Error double book",
      "Hotel Booking Error try again",
      "Hotel.Book: Invalid initials. Must be 2 alpha numeric characters and may not contain any special characters",
      "HotelRoom_1 unavailable HotelId= : RateCode= : RoomCode= : RateAccessCode= : HostCode= : GuestCount= ",
      "ITINERARY_ALREADY_BOOKED",
      "Information required for processing this request could not be created. The requested itinerary has not been created",
      "Invalid country_code.",
      "Invalid number of arguments.",
      "Invalid room guest count. Please provide guest name for each room.",
      "Last Name must be at least two characters in room #1 INVALID_LAST_NAME",
      "Missing confirmation number.",
      "Missing inventory source code",
      "Missing room type or rate plan code",
      "Multiple booking in progress. Please retry",
      "No availabilty found for reservation request. Please try again with correct roomTypeCode and native room rate. queryId= reqRatePlanId= reqRoomTypeId= supplierRatePlanId= supplierRoomTypeId= supplierRatePlanStatus= No Availabilty found for Reservation Request. Please try again with correct roomTypeCode and native room rate.",
      "Only one room at a time may be reserved.",
      "Please resubmit the booking request",
      "Postal code contains invalid (or insufficient) data",
      "Price Change happened for the given product from 1010.54 to USD2021.08 PRICE_CHANGED com.orbitz.tbs.model.PriceChangeException: Sell rate in the request ( 1010.54 ) is less than reprice sell rate (USD2021.08). Change in rate can not process request\\n\\tat com.orbitz.tbs.hotel.txn.HotelReservationServiceImpl.doPriceChangeCheck(HotelReservationServiceImpl.java:543)\\n\\tat com.orbitz.tbs.hotel.txn.HotelReservationServiceImpl.buildBookCriteria(HotelReservationServiceImpl.java:386",
      "Price has changed.",
      "Property not available at booking time",
      "Rate not available.",
      "Reservation Request is duplicated. Please correct the informations or contact us",
      "Reservation Requires Agent to Confirm",
      "Reservation is locked.",
      "Room code invalid",
      "SOLD_OUT The room you were trying to book has sold out. Please choose another. errors.supplier.soldout: Hotel room type not found at this hotel. Please select a different room dates or or hotel",
      "Sorry. Availability not found for Reservation Request. Verify another choice from the available selections to complete the purchase",
      "Supplier Not Ready",
      "The Corporate ID Number supplied is invalid. Please correct or delete the information from the field.",
      "The Corporate ID you entered contained illegal characters. Please correct.",
      "The Frequent Guest ID you entered contained illegal characters. Please correct.",
      "The Frequent Guest Number supplied is invalid. Please correct or delete the information from the field.",
      "The booking is not yet confirmed. Refer to Pending Process",
      "The hotel was unable to provide an itinerary number for the reservation. Please try to make your reservation again at a later time.",
      "The maximum number of persons per room has been exceeded. The room capacity is beyond the maximum number allowed.",
      "The multi-room booking must have a different/unique guest name on each room. Please correct this informations and post again the Reservation",
      "The number of rooms requested is greater than the maximum number of rooms allowed per booking.",
      "The requested number of nights is less than the minimum number of nights required for stay.",
      "The room rate was changed.",
      "The room type or rate you selected is no longer available. Please choose another.",
      "The selected room is sold out",
      "There was a problem with this booking communicating with the backend supplier. This booking will be resolved automatically within 5 minutes. Please DO NOT process a duplicate booking until an itinerary check is made to confirm the status of this booking attempt.",
      "There was a problem with your hotel room reservation. Please select another date or a different hotel and try again",
      "This product is currently not available. com.orbitz.tbs.model.ProductUnavailableException: Both Promoted and Unpromoted SellRates from the reprice should not be null\\n\\tat com.orbitz.tbs.hotel.txn.HotelReservationServiceImpl.validateHotelSelectInfo(HotelReservationServiceImpl.java:503)\\n\\tat com.orbitz.tbs.hotel.txn.HotelReservationServiceImpl.loadBookCriteria(HotelReservationServiceImpl.java:197)\\n\\tat com.orbitz.tbs.hotel.txn.HotelReservationServiceValidatingDecorator.loadBookCriteria(HotelReservationServiceValidatingDecorator.java:37",
      "This product is currently not available. com.orbitz.tbs.model.ProductUnavailableException: Occupancy Validation Error : Cannot find availability for requested rooms\\n\\tat com.orbitz.tbs.hotel.shop.select.PostSelectionProcessor.createStatelessHotelSelectInfo(PostSelectionProcessor.java:268)\\n\\tat com.orbitz.tbs.hotel.shop.select.workflow.StatelessHotelRepriceWorkflow.execute(StatelessHotelRepriceWorkflow.java:77)\\n\\tat com.orbitz.tbs.hotel.shop.select.StatelessRepricer$1.doInMonitor(StatelessRepricer.java:39",
      "This product is currently not available. com.orbitz.tbs.model.SystemException: Caught an exception during lapsang lookupHotelsByMasterID\\n\\tat com.orbitz.tbs.hotel.mgr.HotelSearchMgr.lookupHotelsByMasterID(HotelSearchMgr.java:304)\\n\\tat com.orbitz.tbs.hotel.mgr.HotelSearchMgr.searchByMasterId(HotelSearchMgr.java:186)\\n\\tat com.orbitz.tbs.hotel.mgr.HotelSearchMgr.search(HotelSearchMgr.java:172)\\n\\tat com.orbitz.tbs.hotel.shop.svc.HotelFetchServiceImpl.fetchHotels(HotelFetchServiceImpl.java:106",
      "This product is currently not available. com.orbitz.tbs.model.SystemException: Hotel booking failed due to a hotel booking error. HotelBookException: com.orbitz.hotel.model.service.HotelBookException: Hotel lapsang book service exception: Failed Lapsang Service Invocation. requestURL: http:\\/\\/teakettle.qa1.o.com\\/hotel\\/book\\nstatusCode: 404\\nstatusMessage: Object Not Found\\nserver: TeaKettle-4.11.1\\n\\tat com.orbitz.tbs.hotel.book.handler.HotelBookProductErrorHandler.handleSystemException(HotelBookProductErrorHandler.java:264)\\n\\tat com.orbitz.tbs.hotel.book.handler.HotelBookProductErrorHandler.handleBaseException(HotelBookProductErrorHandler.java:174)\\n\\tat com.orbitz.tbs.hotel.book.handler.HotelBookProductErrorHandler.handleHotelBookExceptions(HotelBookProductErrorHandler.java:126)\\n\\tat com.orbitz.tbs.hotel.book.svc.HotelSpiReservationServiceImpl.bookProduct(HotelSpiReservationServiceImpl.java:358)\\n\\tat com.orbitz.tbs.hotel.book.svc.HotelSpiReservationServiceImpl.bookProduct(HotelSpiReservationServiceImpl.java:136",
      "This reservation can not be completed. Please correct the customer informations and try again",
      "This reservation can not be completed. Please correct the e-mail address",
      "This reservation can not be processed because it has more than 30 days. Correct this information and try again",
      "This reservation can not be processed because the first name contains invalid data. Please correct this reservation and try again",
      "TravelNow.com cannot service this request. The specified email address cannot be resolved",
      "TravelNow.com was unable to appropriately create back-end information required for this request.",
      "Try process your reservation again or contact us",
      "Unable to Add Traveler",
      "Your confirmation number is currently not available. We will email the confirmation number when it becomes available.",
      "error. bookHold Error: Expedia Book Hold Req Failed",
      "error. unknown: Create Order Unexpected Exception: java. util. MissingResource Exception: Couldn't find 3-letter country code for UK java.util. Missing Resource Exception: Couldn't find 3-letter country code for UK at java. util. Locale. getISO3 Country",
      "error.bookingRuleChanged: Hotel rules changed at time of booking.",
      "error.coupon error.currencyHasChanged error.customer FileError error.customer FileError: Customer Add Failed error.duplicateMessageGUID",
      "error.priceMismatch: Internal application error.:MessageReferenceId=UnknownMessageReferenceId. Exception=Hotel price changed during booking",
      "error.unknown: Internal application error.:MessageReferenceId=UnknownMessageReferenceId. Exception=Failed to do a currency conversion.: CommonErrors::MSTError:205 <TNOWERROR_ATTR&gt;<SUPPLIER_ERROR_CODE> CommonErrors::MSTError:205</SUPPLIER_ERROR_CODE></TNOWERROR_ATTR>",
      "mystiquebooking"
    ]
  end
end
