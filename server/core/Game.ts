const READY = "ready";
const PROGRESS = "progress";
const TERMINATED = "terminated"; 
const DECK = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N"];

const WRONG = "wrong";
const CORRECT = "correct";

interface User{
    username: string
    id: string
    socketId: string
    score: number
    rounds: number
    isReady: boolean
}

class Game{

    id: string
    state: string
    turnUser: User | null
    lobby: User[]
    deck: Map<string, User | null>
    deckCount: number
    leader: User
    answerTime: number

    constructor(choices:string[], leader:User, gameId: string){
        this.state = READY;
        this.lobby = [leader];
        this.leader = leader;
        this.deck = new Map();
        choices.forEach((choice) => {
            this.deck.set(choice, null);
        });
        this.deckCount = choices.length;
        this.answerTime = 7000;
        this.turnUser = null;
        this.id = gameId;
    }

    isUserTurn(socketId:string){
        if(this.turnUser !== null){
            return this.turnUser.socketId === socketId;
        }
        return false;
    }

    canUserJoin(){
        return this.state === READY;
    }

    hasTerminated(){
        return this.state === TERMINATED;
    }

    isLobbyReady(){
        return this.state === PROGRESS;
    }

    onUserJoin(user:User){
        this.lobby.push(user);
    }

    onUserLeave(socketId: string){
        this.lobby = this.lobby.filter((u) => {
            return u.socketId !== socketId;
        });
        if(this.lobby.length === 0){
            this.state = TERMINATED;
        }
        else{
            if(this.leader.socketId === socketId){
                this.leader = this.lobby[0];
            }
        }
    }

    onUserToggleIsReady(socketId: string, toggle:boolean){
        const user = this.lobby.find((u)=> {
            return u.socketId === socketId;
        });
        if(user){
            user.isReady = toggle;
            const readiedUsers = this.lobby.filter((u) => u.isReady);
            if(this.lobby.length === readiedUsers.length){
                this.state = PROGRESS;
            }
        }
    }

    onPick(){
        let pickedUser = this.lobby[0];
        for(const user of this.lobby){
            if(user.rounds < pickedUser.rounds){
                pickedUser = user;
            }
        }
        this.turnUser = pickedUser;
    }

    onAnswer(answer:string){
        if(this.deck.has(answer)){
            const answerUser = this.deck.get(answer);
            if(answerUser && answerUser !== null){
                return {status: WRONG, message: `${answerUser.username} has already said this`}
            }
            else{
                if(this.turnUser && this.turnUser !== null){
                    this.turnUser.score++;
                    this.turnUser.rounds++;
                }
                this.deck.set(answer, this.turnUser);
                this.deckCount--;
                return {status: CORRECT, message: "Your answer is a valid option in the deck"};
            }
        }   
        else{
            return {status: WRONG, message: "Your answer is not even an option in the deck"};
        }
    }

    onFailure(){
        if(this.turnUser !== null){
            this.turnUser.rounds++;
        }
    }

    serialize(){
        return this;
    }

    getLobby(){
        return this.lobby;
    }

    getAnswerTime(){
        return this.answerTime;
    } 

    getTurnUser(){
        return this.turnUser;
    }
}

export {Game, DECK, WRONG, CORRECT};