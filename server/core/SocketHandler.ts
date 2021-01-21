import { Server, Socket } from "socket.io";
import { Game, DECK, CORRECT} from "./Game";

const gameManager = new Map<string, Game>();
const timeoutManager = new Map<string, NodeJS.Timeout | null>();

const getGameId = (socket: Socket) => {
    const rooms = Array.from(socket.rooms);
    const games = rooms.filter((room) => {
        return room !== socket.id;
    });
    return games[0];
}

const onDisconnecting = (socket: Socket, io: Server) => {
    return () => {

        if (socket.rooms.size > 0) {
            const gameId = getGameId(socket);
            if (gameManager.has(gameId)) {
                const game = gameManager.get(gameId) as Game;
                const isTurnUserLeaving = game.isUserTurn(socket.id);
                game.onUserLeave(socket.id);

                if (game.hasTerminated()) {
                    gameManager.delete(gameId);
                    const timeout = timeoutManager.get(gameId);
                    if (timeout && timeout !== null) {
                        clearTimeout(timeout);
                    }
                    timeoutManager.delete(gameId);
                }
                else {
                    if (isTurnUserLeaving) {
                        onPrompt(gameId, io);
                    }
                }
            }
        }
    }
}

type GameJoin = {
    gameId: string,
    userId: string,
    username: string
}

const onCreate = (socket: Socket, io: Server) => {

    return ({ gameId, userId, username }: GameJoin) => {

        const leader = {
            username: username,
            id: userId,
            score: 0,
            socketId: socket.id,
            rounds: 0,
            isReady: false
        };

        const game = new Game(DECK, leader, gameId);
        gameManager.set(gameId, game);
        timeoutManager.set(gameId, null);
        socket.join(gameId);
    }
}


const onJoin = (socket: Socket, io: Server) => {
    return ({ gameId, userId, username }: GameJoin) => {

        const user = {
            username: username,
            id: userId,
            score: 0,
            socketId: socket.id,
            rounds: 0,
            isReady: false
        };

        if (gameManager.has(gameId)) {
            const game = gameManager.get(gameId) as Game;
            if (game.canUserJoin()) {
                game.onUserJoin(user);
                socket.join(gameId);
            }
            else {
                io.to(socket.id).emit("error", {
                    message: "The game you are trying to join is already in progress"
                });
            }
        }
        else {
            io.to(socket.id).emit("error", {
                message: "The game you are trying to join doesn't exist"
            });
        }
    }
}

type GameToggle = {
    toggle: boolean
}

const onToggleReady = (socket: Socket, io: Server) => {

    return ({ toggle }: GameToggle) => {

        if (socket.rooms.size > 0) {
            const gameId = getGameId(socket);
            if (gameManager.has(gameId)) {
                const game = gameManager.get(gameId) as Game;
                game.onUserToggleIsReady(socket.id, toggle);
                if (game.isLobbyReady()) {
                    onPrompt(gameId, io);
                }
            }
        }
    }
}

const sendGameState = (gameId:string, io: Server) => {
    if(gameManager.has(gameId)){
        const game = gameManager.get(gameId) as Game;
        io.to(gameId).emit("gameState", game.serialize());
    }
}

const onPrompt = (gameId: string, io: Server) => {
    
    if (gameManager.has(gameId)) {
        const game = gameManager.get(gameId) as Game;
        let timeout = timeoutManager.get(gameId);

        if (timeout && timeout !== null) {
            clearTimeout(timeout);
        }

        game.onPick();
        sendGameState(gameId, io);
        
        timeoutManager.set(gameId, setTimeout(() => {
            game.onFailure();
            onPrompt(gameId, io);

        }, game.getAnswerTime()));
    }
};

type GameAnswer = {
    answer: string
}

const onAnswer = (socket: Socket, io: Server) => {

    return ({answer}: GameAnswer) => {

        if(socket.rooms.size > 0){
            const gameId = getGameId(socket);
            if(gameManager.has(gameId)){

                const game = gameManager.get(gameId) as Game;

                if(game.isUserTurn(socket.id)){
                    const {status, message} = game.onAnswer(answer);
                    io.to(gameId).emit("answerResponse", {
                        status: status,
                        message: message
                    });
                    if(status === CORRECT){
                        onPrompt(gameId, io);
                    }
                }
                else{
                    io.to(socket.id).emit("error", {
                        message: "This client should be restricted from answering since its not their turn"
                    });
                }
            }
        }
    }
};


export { onDisconnecting, onCreate, onJoin, onToggleReady, onAnswer, gameManager};