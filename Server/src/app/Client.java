package app;

import utils.socket.DataArrivalEvent;
import utils.socket.SClient;
import utils.socket.SClientAdapter;
import utils.socket.SClientListener;
import utils.socket.message.ErrorMessage;
import messages.PingRequest;
import messages.PingResponse;

import java.io.IOException;
import java.net.Socket;
import java.util.HashMap;

public class Client {
    private final HashMap<Class, IMessageCallback> messagesCallback = new HashMap<>();
    private SClient socket;

    public interface IMessageCallback {
        void run(DataArrivalEvent e);
    }

    public Client(Socket socket) {
        try {
            this.registerCallback();
            this.socket = new SClient(socket, clientEvent);
        } catch (IOException e) {
            System.err.println("[Serveur] Erreur cr�ation du client.");
            e.printStackTrace();
        }
    }

    public SClientListener clientEvent = new SClientAdapter() {
        @Override
        public void onDataArrival(SClient sender, DataArrivalEvent event) {
            //TODO: Si non connect� & non LoginRequest, retourne une erreur ?
            if(messagesCallback.containsKey(event.getMessageClass()))
                messagesCallback.get(event.getMessageClass()).run(event);
            else if(event.isRequest())
                event.setResponse(new ErrorMessage(0, "Request not found"));
        }

        @Override
        public void onClosed(SClient sender) {
            System.out.println("[Serveur] Deconnexion du client");
        }
    };


    ///////////////// Gestion des messages ///////////////

    private void registerCallback() {
        messagesCallback.put(PingRequest.class, onPingRequest);
    }

    public IMessageCallback onPingRequest = data -> {
        data.setResponse(new PingResponse());
    };

}
