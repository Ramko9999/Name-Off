class Player {

    String username;
    String id;
    String socketId;
    int score;
    int rounds;
    bool isReady;
    
    Player(String username, String id, String socketId, int score, int rounds, bool isReady) {
      this.username = username;
      this.id = id;
      this.socketId = socketId;
      this.score = score;
      this.rounds = rounds;
      this.isReady = isReady;
    }
}