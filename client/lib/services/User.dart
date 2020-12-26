import "../models/User.dart";

class UserApi {

  static Future<User> createUser(String username) async {
    return User("", "", 0);
  }

  static Future<User> getUser(String id) async {
    return User("", "", 0);
  }
  
}