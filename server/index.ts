import {httpServer} from "./core/HttpServer";
import {Socket} from "socket.io";
import {onDisconnecting, onCreate, onJoin, onToggleReady, onAnswer} from "./core/SocketHandler";


const socketServer = require("socket.io")(httpServer);

socketServer.on("connection", (socket:Socket) => {
    socket.on("create", onCreate(socket, socketServer));
    socket.on("disconnecting", onDisconnecting(socket, socketServer));
    socket.on("join", onJoin(socket, socketServer));
    socket.on("toggleReady", onToggleReady(socket, socketServer));
    socket.on("answer", onAnswer(socket, socketServer));
});


httpServer.listen(5000, () => {
    console.log("Listening...");
});




