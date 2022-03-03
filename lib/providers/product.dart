import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// class that define what the caracters of a product
class Product with ChangeNotifier{

  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;


  Product({
    @required    this.id,
    @required   this.title,
   @required  this.description,
    @required   this.price,
    @required  this.imageUrl,
     this.isFavorite = false,
  });

  void _setNewValue(bool newValue){
      isFavorite = newValue;
         notifyListeners();
  }

Future<void> toggleFavoriteStatus(String token, String userId) async{
  final oldStatus = isFavorite;
  isFavorite = !isFavorite;
  notifyListeners();
  final url = 'https://flutter-update-8aee4-default-rtdb.firebaseio.com/userFvorites/$userId/$id.json?auth=$token';
  try {
    final response = await http.put(
    url,
   body: json.encode(
           isFavorite,
   ),
   );
    if (response.statusCode >= 400) {
       _setNewValue(oldStatus);
    }
  } catch (error) {
    _setNewValue(oldStatus);
  }
}


}