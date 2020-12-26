import "../models/User.dart";
import "../util/ApiConfig.dart";
import "package:http/http.dart";
import "dart:convert";

class UserApi {

  static Future<User> createUser(String username) async {
    String endpoint = ApiConfig.baseUrl + "user/create";
    Response response = await post(endpoint, headers:{'Content-Type': "application/json"}, body:json.encode({"username": username}));
    if(response.statusCode == 200){
      Map<String, dynamic> userJson = json.decode(response.body);
      return User.fromJson(userJson);
    }
    else{
      throw Exception("Unable to create user"); 
    }
  }

  static Future<User> getUser(String id) async {
    String endpoint = ApiConfig.baseUrl + "user/" + id;
    Response response = await get(endpoint);
    if(response.statusCode == 200){
      Map<String, dynamic> userJson = json.decode(response.body);
      return User.fromJson(userJson);
    }
    else{
      throw Exception("Unable to get user: " + id);
    }
  }
  
}