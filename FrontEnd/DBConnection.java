package proyectotbd1;

   import java.sql.Connection;
import java.sql.DriverManager;
public class DBConnection {
    public static Connection conectar() {

        Connection conn = null;

        try {

            Class.forName("sap.jdbc4.sqlanywhere.IDriver");

            String url = "jdbc:sqlanywhere:uid= Maria Rodriguez ;pwd=Estrella.4;"
                    + "dbf=C:/Users/Maria Gabriela/OneDrive/Desktop/Ingenieria en Sistemas/TBD/22441044_ProyectoTBD.db";

            conn = DriverManager.getConnection(url);


        } catch (Exception e) {

            System.out.println("Error de conexion: " + e.getMessage());

        }

        return conn;
    }
}
