class EquipmentModel{
  String equipmentName;
  String equipmentPrice;
  int selectedCount;
  DateTime addedTime;
  String id;
  String addedBy;
  String addedAdmin;
  int requeredCount;
  int collectedCount;
  String photo;
  bool selectedBool;
  EquipmentModel(this.equipmentName,this.equipmentPrice,this.selectedCount,this.addedTime,this.id,this.addedBy,this.addedAdmin
      ,this.requeredCount,this.collectedCount,this.photo,this.selectedBool);

}

class SponserModel{
  String id;
  String name;
  String photo;
  DateTime addedTime;
  String addedBy;
  String phone;
  SponserModel(this.id,this.name,this.photo,this.addedTime,this.addedBy,this.phone);
}

class VoulenteerModel{
  String id;
  String name;
  String photo;
  DateTime addedTime;
  String addedBy;
  String deviceID;
  String status;
  String number;
  String time;
  VoulenteerModel(this.id,this.name,this.photo,this.addedTime,this.addedBy,this.deviceID,this.status,this.number,this.time);
}

class SponsershipDiseaseModel{
  String name;
  int count;
  int price;
  String assetPath;
  bool selectionBool;
  SponsershipDiseaseModel(this.name,this.count,this.price,this.selectionBool,this.assetPath);
}

class FoodKitSponsorModel{
  int price;
  int count;
  FoodKitSponsorModel(this.price,this.count);
}

class MonthModel{
  String month;
  int count;
  MonthModel(this.month,this.count);
}