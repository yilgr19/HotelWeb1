package hotelweb.dao;

import hotelweb.models.Producto; 
import hotelweb.models.Venta;
import hotelweb.models.DetalleVenta;
import hotelweb.models.Cliente; // Importación CLAVE
import hotelweb.util.ConexionBD; // Asumiendo que tienes esta clase
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Random; 

public class VentaDAO {

    // 🛑 MÉTODO NUEVO: BÚSQUEDA DEL CLIENTE POR CÉDULA
    public Cliente buscarClientePorCedula(String cedula) {
        // La consulta debe traer todos los campos necesarios para el modelo Cliente
        String sql = "SELECT idCliente, cedula, nombre, apellido, telefono, direccion, correo FROM clientes WHERE cedula = ?";
        Cliente c = null;
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, cedula);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                c = new Cliente();
                // Usamos los setters de tu clase Cliente
                c.setIdCliente(rs.getInt("idCliente"));
                c.setCedula(rs.getString("cedula"));
                c.setNombre(rs.getString("nombre"));
                c.setApellido(rs.getString("apellido"));
                c.setTelefono(rs.getString("telefono"));
                c.setDireccion(rs.getString("direccion"));
                c.setCorreo(rs.getString("correo"));
            }
        } catch (Exception e) { 
            e.printStackTrace(); 
            // Manejo de error de BD
        }
        return c;
    }
    
    // -----------------------------------------------------------
    // Los siguientes métodos son necesarios pero se omiten para brevedad,
    // asumiendo que ya los tienes (buscarProductoPorCodigo, generarNumeroFactura, registrarVenta)
    // -----------------------------------------------------------
    
    // Ejemplo de buscarProductoPorCodigo (manteniendo consistencia)
    public Producto buscarProductoPorCodigo(String codigo) {
        // Lógica de BD para buscar producto...
        return null; // Cambiar por tu implementación real
    }

    // Ejemplo de generarNumeroFactura (manteniendo consistencia)
    public String generarNumeroFactura() {
        // Lógica de BD para generar número de factura...
        return "F-00001"; // Cambiar por tu implementación real
    }
    
    // Ejemplo de registrarVenta (manteniendo consistencia)
    public boolean registrarVenta(Venta venta) throws SQLException {
        // Lógica de BD para registrar venta y detalles...
        return true; // Cambiar por tu implementación real
    }
}