import './locationservices.dart';



class NewPost {
  var date; 
  var imageURL;
  var latitude; 
  var longitude; 
  final quantity;
  NewPost(this.quantity,[this.imageURL,this.latitude,this.longitude,this.date]);

  setLat(double lat){
    latitude = lat; 
  }

  setLong(double long){
    longitude = long; 
  }

  setURL(String url){
    imageURL = url; 
  }
  setDate(DateTime dateset){
    date = dateset; 
  }

  double getlat(){
    return latitude; 
  }

  double getlong(){
    return longitude; 
  }

  String getquantity(){
    return quantity; 
  }

  DateTime getdate(){
    return date; 
  }

  String getURL(){
    return imageURL; 
  }

   generateLocation()async {
    final location = await WasteLocation().getlocation(); 
    setLat(location.latitude);
    setLong(location.longitude);
  }


}