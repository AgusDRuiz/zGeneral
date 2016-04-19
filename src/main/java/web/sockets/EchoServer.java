package web.sockets;


import java.util.logging.Level;
import java.util.logging.Logger;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint(value = "/chat")
public class EchoServer {

    
    @OnOpen
    public void onOpen(Session session) {
        System.out.println(session.getId() + " has opened a connection"); 
    }
    
    @OnMessage
    public String onMessage(String message, Session session) {
        System.out.println("Message from " + session.getId() + ": " + message);
        return "Server received [" + message + "]";
    }
    
    @OnClose
    public void onClose(Session session) {
        System.out.println("Session " +session.getId()+" has ended");
    }
    
    @OnError
    public void onError(Throwable exception, Session session) {
        System.out.println("Error for client: {0}:  "+ session.getId());
    }
}
