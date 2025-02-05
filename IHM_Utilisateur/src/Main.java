import Controllers.UserConnectionWindowController;
import Models.AppUser;
import Models.Internet;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class Main extends Application {
    public static void main(String[] args) {
        launch(args);
    }

    @Override
    public void start(Stage primaryStage) throws Exception {
        if ((!Internet.TestConnectivity()) || (!AppUser.testServerAccess()))
            System.exit(1);

        FXMLLoader loader = new FXMLLoader(getClass().getResource("Views/UserConnectionWindowView.fxml"));
        Parent root = loader.load();
        UserConnectionWindowController userConnectionWindowController = loader.getController();
        userConnectionWindowController.stage = primaryStage;
        primaryStage.setTitle("Connexion");
        primaryStage.setScene(new Scene(root));
        primaryStage.setResizable(false);
        primaryStage.setOnCloseRequest(action -> AppUser.sClient.close());
        primaryStage.show();
    }
}
