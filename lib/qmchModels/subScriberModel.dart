
class SubScriberModel{
  String subScriberName;
  String subScriberPhoneNumber;
  String subScriberAddress;
  DateTime addedTime;
  String id;
  String addedBy;
  String addedAdmin;
  String photo;
  SubScriberModel(this.subScriberName,this.subScriberPhoneNumber,this.subScriberAddress,this.addedTime,this.id,this.addedBy,this.addedAdmin,
      this.photo
      );
}

class VoulenteerPaymentsModel{
  String id;
  String name;
  String phone;
  String voulenteerID;
  String voulenteerName;
  DateTime addedTime;
  String addedTimeMillis;
  String amount;
  String status;
  VoulenteerPaymentsModel(this.id,this.name,this.phone,this.voulenteerID,this.voulenteerName,this.addedTime,
      this.addedTimeMillis,this.amount,this.status);

}

class MonthBool{
  String monthName;
  String payStatus;
  String year;
  bool selectionBool;
  MonthBool(this.monthName,this.payStatus,this.year,this.selectionBool);
}

class SubscriberPaymentModel{
  String subscriberID;
  String paymentid;
  String monthName;
  String payStatus;
  String year;
  String paymentDateMillis;
  String amonut;
  int position;
  SubscriberPaymentModel(this.subscriberID,this.paymentid,this.monthName,this.payStatus,this.year,this.paymentDateMillis,this.amonut,this.position,);
}