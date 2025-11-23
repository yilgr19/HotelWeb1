package hotelweb.dao;

import hotelweb.models.Habitacion;
import hotelweb.util.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class HabitacionDAO {

    // --- MÉTODOS ESPECIALES PARA RESERVAS ---

    public String obtenerHabitacionDisponible(String tipo) {
        String habitacion = null;
        
        // CORRECCIÓN IMPORTANTE: Usamos LOWER() para ignorar mayúsculas/minúsculas
        String sql = "SELECT numero FROM habitaciones WHERE LOWER(tipo) = LOWER(?) AND estado = 'Disponible' LIMIT 1";

        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, tipo); // El usuario manda "simple", la BD tiene "Simple" -> LOWER lo iguala.
            
            // DEBUG: Mensaje en consola para verificar qué busca
            System.out.println("DEBUG DAO: Buscando habitación tipo: " + tipo);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    habitacion = rs.getString("numero");
                    System.out.println("DEBUG DAO: ¡Encontrada! Habitación N° " + habitacion);
                } else {
                    System.out.println("DEBUG DAO: No se encontró ninguna habitación disponible para tipo " + tipo);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error buscando habitación: " + e.getMessage());
        }
        return habitacion;
    }

    public boolean cambiarEstadoHabitacion(String numero, String nuevoEstado) {
        String sql = "UPDATE habitaciones SET estado = ? WHERE numero = ?";
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, nuevoEstado);
            ps.setString(2, numero);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error cambiando estado: " + e.getMessage());
            return false;
        }
    }

    // --- MÉTODOS CRUD PARA GESTIÓN DE HABITACIONES (Formulario NuevaHabitacion) ---

    public boolean guardarHabitacion(Habitacion h) {
        String sql = "INSERT INTO habitaciones (numero, tipo, precio, estado) VALUES (?, ?, ?, ?)";
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, h.getNumero());
            ps.setString(2, h.getTipo());
            ps.setDouble(3, h.getPrecio());
            ps.setString(4, h.getEstado());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error guardando habitación: " + e.getMessage());
            return false;
        }
    }

    public Habitacion buscarHabitacion(String numero) {
        String sql = "SELECT * FROM habitaciones WHERE numero = ?";
        Habitacion h = null;
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, numero);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    h = new Habitacion(
                        rs.getInt("id_habitacion"),
                        rs.getString("numero"),
                        rs.getString("tipo"),
                        rs.getDouble("precio"),
                        rs.getString("estado")
                    );
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return h;
    }

    public boolean eliminarHabitacion(String numero) {
        String sql = "DELETE FROM habitaciones WHERE numero = ?";
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, numero);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { return false; }
    }
}