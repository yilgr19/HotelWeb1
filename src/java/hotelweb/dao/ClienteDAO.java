package hotelweb.dao;

import hotelweb.models.Cliente;
import hotelweb.util.ConexionBD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ClienteDAO {

    /**
     * Inserta un nuevo cliente en la base de datos.
     */
    public boolean registrarCliente(Cliente cliente) throws SQLException {
        
        String sql = "INSERT INTO cliente (cedula, nombre, apellido, telefono, direccion, correo) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, cliente.getCedula());
            ps.setString(2, cliente.getNombre());
            ps.setString(3, cliente.getApellido());
            ps.setString(4, cliente.getTelefono());
            ps.setString(5, cliente.getDireccion());
            ps.setString(6, cliente.getCorreo());
            
            return ps.executeUpdate() > 0;
        
        } catch (SQLException e) {
            System.err.println("Error al registrar cliente: " + e.getMessage());
            throw e;
        }
    }

    /**
     * Actualiza los datos de un cliente existente.
     */
    public boolean actualizarCliente(Cliente cliente) throws SQLException {
        
        String sql = "UPDATE cliente SET nombre = ?, apellido = ?, telefono = ?, direccion = ?, correo = ? WHERE cedula = ?";
        
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, cliente.getNombre());
            ps.setString(2, cliente.getApellido());
            ps.setString(3, cliente.getTelefono());
            ps.setString(4, cliente.getDireccion());
            ps.setString(5, cliente.getCorreo());
            ps.setString(6, cliente.getCedula());
            
            return ps.executeUpdate() > 0;
        
        } catch (SQLException e) {
            System.err.println("Error al actualizar cliente: " + e.getMessage());
            throw e;
        }
    }

    /**
     * Busca un cliente por su Cédula.
     */
    public Cliente buscarPorCedula(String cedula) throws SQLException {
        String sql = "SELECT * FROM cliente WHERE cedula = ?";
        Cliente cliente = null;

        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, cedula);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
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
        return cliente;
    }

    /**
     * Verifica si un cliente existe por su Cédula.
     */
    public boolean existeCliente(String cedula) throws SQLException {
        String sql = "SELECT COUNT(*) FROM cliente WHERE cedula = ?";
        
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, cedula);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        }
        return false;
    }

    /**
     * Elimina un cliente por su Cédula.
     */
    public boolean eliminarPorCedula(String cedula) throws SQLException {
        String sql = "DELETE FROM cliente WHERE cedula = ?";
        
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, cedula);
            
            return ps.executeUpdate() > 0;
        }
    }
}