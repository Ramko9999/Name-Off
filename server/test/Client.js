
var io = require("socket.io-client");

class User{

    constructor(username, userId, timeout){
        this.username = username;
        this.userId = userId;
        this.client = null;
        
        setTimeout(() => {
            if(this.client !== null){
                this.disconnect();
            }
        }, timeout)
    }

    connect(url){
        this.client = io.connect(url);
        this.client.on("connect", () => {
            console.log(`Connected! ${this.username}`);
        });
        this.client.on("error", ({message}) => {
            console.log("Error: " + message);
            this.disconnect();
        })
    }

    create(gameId){
        this.client.emit("create", {
            userId: this.userId,
            gameId: gameId,
            username: this.username
        });
    }

    join(gameId){
        this.client.emit("join", {
            userId: this.userId,
            gameId: gameId,
            username: this.username
        });
    }

    isReady() {
        this.client.emit("toggleReady", {
            toggle: true
        });
    }
    disconnect(){
        console.log("disconnecting");
        this.client.disconnect();
    }

}


const gameId = "R89-JKL-190";

const leader = new User("Ramko9999", "18ssj-1229d-ajsd-9881", 20000);
leader.connect("http://localhost:5000");
leader.create(gameId);

const player1 = new User("RohanShiva19", "xyas-19d-ajsd-9881", 45000);
player1.connect("http://localhost:5000");
player1.join(gameId);

const player2 = new User("CharlseShi123", "abc-asdj-ansvl-11nka", 45000);
player2.connect("http://localhost:5000");
player2.join(gameId);

setTimeout( () => {
    player1.isReady();
    leader.isReady();
    player2.isReady();
    user = new User("Tejesh11v", "abcd-efgh-ljki-1234", 20000);
    user.connect("http://localhost:5000");
    user.join(gameId);
}, 10000);
