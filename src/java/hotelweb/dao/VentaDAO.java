// Ubicación: hotelweb.dao.VentaDAO

package hotelweb.dao;

import hotelweb.util.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class VentaDAO {

    /**
     * Genera el siguiente número de factura (ej. F000001)
     */
    public String generarNumeroFactura() {
        String serie = "F";
        int numero = 0;
        // Consulta SQL para obtener el máximo número de factura
        String sql = "SELECT MAX(CAST(SUBSTR(numero_factura, 2) AS UNSIGNED)) AS max_numero FROM venta";
        
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next() && rs.getString("max_numero") != null) {
                numero = rs.getInt("max_numero") + 1;
            } else {
                numero = 1; // Empieza en 1 si no hay registros
            }
            
            // Retorna la serie + número formateado con 6 ceros
            return serie + String.format("%06d", numero);
            
        } catch (SQLException e) {
            System.err.println("Error al generar número de factura: " + e.getMessage());
            return "ERROR_0000"; 
        }
    }
    
    // (Aquí iría el futuro método registrarVenta)
}