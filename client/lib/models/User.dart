class User{
  String _id;
  String _username;
  int _gamesPlayed;

  
  User(String id, String username, int gamesPlayed){
    this._id = id;
    this._username = username;
    this._gamesPlayed = gamesPlayed;
  }

  User.fromJson(Map<String, dynamic> json){
    bool isJsonValid = json.containsKey("id") && json.containsKey("username") && json.containsKey("games_played");
    if(!isJsonValid){
      throw Exception("Invalid Json. Fields are missing from data");
    }
    this._id = json["id"];
    this._username = json["username"];
    this._gamesPlayed = json["games_played"];
  }

  String getId(){
    return this._id;
  }

  String getUsername(){
    return this._username;
  }

  int getGamesPlayed(){
    return this._gamesPlayed;
  }

  Map<String, dynamic> serialize(){
    return {
      "id": this._id,
      "username": this._username,
      "games_played": this._gamesPlayed
    };
  }

}