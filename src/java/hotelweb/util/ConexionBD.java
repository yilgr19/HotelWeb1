package hotelweb.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {
    
    // --- ¡VERIFICA ESTA CONFIGURACIÓN! ---
    
    /**
     * ¡REVISA EL PUERTO!
     * ¿Tu XAMPP-MySQL está corriendo en el puerto 3307?
     * Si está en el 3306, debes cambiar "localhost:3307" a "localhost:3306".
     */
   private static final String URL = "jdbc:mysql://localhost:3306/hotel_db?useSSL=false&serverTimezone=UTC";
    
    /**
     * ¡REVISA EL USUARIO!
     * El usuario por defecto de XAMPP es "root".
     */
    private static final String USER = "root"; 
    
    /**
     * ¡REVISA LA CONTRASEÑA!
     * La contraseña por defecto de XAMPP es VACÍA ("").
     * Si le pusiste una contraseña a tu 'root', escríbela aquí.
     */
    private static final String PASSWORD = ""; 
    // ------------------------------------

    /**
     * ¡REVISA EL DRIVER!
     * Esto es correcto si descargaste el "mysql-connector-j-8.0.xx.jar"
     * y lo pegaste en la carpeta WEB-INF/lib.
     */
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";

    /**
     * Obtiene una conexión a la base de datos de XAMPP.
     * @return un objeto Connection
     * @throws SQLException si falla la conexión o el driver no se encuentra.
     */
    public static Connection getConnection() throws SQLException {
        try {
            // 1. Registramos el driver
            Class.forName(DRIVER); 
            
            // 2. Obtenemos la conexión
            // (Si "se queda pensando y falla", es porque los datos de
            // URL, USER o PASSWORD de arriba no coinciden con tu XAMPP)
            return DriverManager.getConnection(URL, USER, PASSWORD);
            
        } catch (ClassNotFoundException e) {
            // Este error saldrá si te falta el archivo .jar en WEB-INF/lib
            System.err.println("Error: Driver JDBC no encontrado. (Revisa si copiaste el .jar en WEB-INF/lib)");
            e.printStackTrace();
            throw new SQLException("Error de driver", e);
        } catch (SQLException e) {
            // Este error saldrá si el puerto, usuario o contraseña son incorrectos
            System.err.println("Error al conectar a la base de datos (Revisa URL, User, Pass): " + e.getMessage());
            e.printStackTrace();
            // Relanzamos la excepción para que el servlet la atrape
            throw e; 
        }
    }
}