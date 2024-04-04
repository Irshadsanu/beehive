
class FoodKitModel{
  String foodName;
  String foodDescription;
  String foodPrice;
  DateTime addedTime;
  String id;
  String addedBy;
  String addedAdmin;
  FoodKitModel(this.foodName,this.foodDescription,this.foodPrice,this.addedTime,this.id,this.addedBy,this.addedAdmin);
}


class FoodKitDateModel{
  String dateFormat;
  DateTime date;
  FoodKitDateModel(this.dateFormat, this.date);
}

class NewsFeedModel{
  String id;
  String title;
  String description;
  String addedBy;
  DateTime addedTime;
  String nowDifferece ;
  String image ;

  NewsFeedModel(this.id,this.title,this.description,this.addedBy,this.addedTime,this.nowDifferece,this.image);
}

class CarouselModel{
  String id;
  String addedBy;
  List<dynamic> carousolImages;
  CarouselModel(this.id,this.addedBy,this.carousolImages);

}