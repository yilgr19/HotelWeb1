package hotelweb.dao;

import hotelweb.models.Cliente;
import hotelweb.util.ConexionBD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ClienteDAO {

    /**
     * Inserta un nuevo cliente en la base de datos (¡Actualizado!).
     */
    public boolean registrarCliente(Cliente cliente) throws SQLException {
        
        // ¡ESTE ES EL SQL CORRECTO! (Usa 'cedula', 'direccion', 'correo')
        String sql = "INSERT INTO cliente (cedula, nombre, apellido, telefono, direccion, correo) VALUES (?, ?, ?, ?, ?, ?)";
        
        // Usamos try-with-resources para cerrar la conexión automáticamente
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            // ¡ESTOS SON LOS GETTERS CORRECTOS!
            // La línea 26 (donde tenías tu error) es esta:
            ps.setString(1, cliente.getCedula());
            ps.setString(2, cliente.getNombre());
            ps.setString(3, cliente.getApellido());
            ps.setString(4, cliente.getTelefono());
            ps.setString(5, cliente.getDireccion());
            ps.setString(6, cliente.getCorreo());
            
            return ps.executeUpdate() > 0; // Retorna true si 1 fila fue insertada
        
        } catch (SQLException e) {
            System.err.println("Error al registrar cliente: " + e.getMessage());
            throw e; // Relanza el error para que el servlet lo atrape
        }
    }

    /**
     * Busca un cliente por su Cédula (¡Nuevo!).
     */
    public Cliente buscarPorCedula(String cedula) throws SQLException {
        String sql = "SELECT * FROM cliente WHERE cedula = ?";
        Cliente cliente = null;

        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, cedula);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Si encontramos un resultado, creamos el objeto Cliente
                    cliente = new Cliente(
                        rs.getInt("idCliente"),
                        rs.getString("cedula"),
                        rs.getString("nombre"),
                        rs.getString("apellido"),
                        rs.getString("telefono"),
                        rs.getString("direccion"),
                        rs.getString("correo")
                    );
                }
            }
        }
        return cliente; // Retorna el cliente (o null si no se encontró)
    }

    /**
     * Elimina un cliente por su Cédula (¡Nuevo!).
     */
    public boolean eliminarPorCedula(String cedula) throws SQLException {
        String sql = "DELETE FROM cliente WHERE cedula = ?";
        
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, cedula);
            
            return ps.executeUpdate() > 0; // Retorna true si se eliminó algo
        }
    }
}