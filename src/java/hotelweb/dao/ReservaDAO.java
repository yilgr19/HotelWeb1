package hotelweb.dao;

import hotelweb.models.Reserva;
import hotelweb.util.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ReservaDAO {

    // Método para buscar habitación disponible automáticamente
    public String asignarHabitacionAutomatica(String tipoHabitacion) {
        String habitacion = "Sin Disponibilidad";
        // IMPORTANTE: Asegurate de tener una tabla 'habitaciones' con columna 'tipo' y 'estado'
        String sql = "SELECT numero FROM habitaciones WHERE tipo = ? AND estado = 'Disponible' LIMIT 1";
        
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, tipoHabitacion);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    habitacion = rs.getString("numero");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error buscando habitación: " + e.getMessage());
        }
        return habitacion;
    }

    public boolean registrarReserva(Reserva reserva) throws SQLException {
        // SQL MODIFICADO: Agregamos cliente_nombre, cliente_apellido, cliente_telefono
        String sql = "INSERT INTO reserva (fecha_entrada, hora_entrada, fecha_salida, hora_salida, "
                   + "tipo_habitacion, num_huespedes, habitacion_asignada, metodo_pago, "
                   + "estado_reserva, cliente_cedula, cliente_nombre, cliente_apellido, cliente_telefono) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, reserva.getFechaEntrada());
            ps.setString(2, reserva.getHoraEntrada());
            ps.setString(3, reserva.getFechaSalida());
            ps.setString(4, reserva.getHoraSalida());
            ps.setString(5, reserva.getTipoHabitacion());
            ps.setInt(6, reserva.getNumHuespedes());
            ps.setString(7, reserva.getHabitacionAsignada());
            ps.setString(8, reserva.getMetodoPago());
            ps.setString(9, reserva.getEstadoReserva());
            ps.setString(10, reserva.getCedulaCliente());
            // NUEVOS DATOS
            ps.setString(11, reserva.getClienteNombre());
            ps.setString(12, reserva.getClienteApellido());
            ps.setString(13, reserva.getClienteTelefono());
            
            int filas = ps.executeUpdate();
            
            // Si registramos la reserva, marcamos la habitación como ocupada
            if(filas > 0 && !reserva.getHabitacionAsignada().equals("Sin Disponibilidad")) {
                actualizarEstadoHabitacion(reserva.getHabitacionAsignada(), "Ocupado");
            }
            return filas > 0;
        } catch (SQLException e) {
            System.err.println("Error SQL al reservar: " + e.getMessage());
            throw e; 
        }
    }

    private void actualizarEstadoHabitacion(String numero, String estado) {
        String sql = "UPDATE habitaciones SET estado = ? WHERE numero = ?";
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, estado);
            ps.setString(2, numero);
            ps.executeUpdate();
        } catch (SQLException ex) { ex.printStackTrace(); }
    }

    public Reserva buscarReservaPorCedula(String cedula) throws SQLException {
        String sql = "SELECT * FROM reserva WHERE cliente_cedula = ? ORDER BY idReserva DESC LIMIT 1";
        Reserva reserva = null;

        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, cedula);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    reserva = new Reserva(
                        rs.getInt("idReserva"),
                        rs.getString("fecha_entrada"),
                        rs.getString("hora_entrada"),
                        rs.getString("fecha_salida"),
                        rs.getString("hora_salida"),
                        rs.getString("tipo_habitacion"),
                        rs.getInt("num_huespedes"),
                        rs.getString("habitacion_asignada"),
                        rs.getString("metodo_pago"),
                        rs.getString("estado_reserva"),
                        rs.getString("cliente_cedula"),
                        // Recuperamos los nuevos campos
                        rs.getString("cliente_nombre"),
                        rs.getString("cliente_apellido"),
                        rs.getString("cliente_telefono")
                    );
                }
            }
        }
        return reserva;
    }

    public boolean eliminarReservaPorCedula(String cedula) throws SQLException {
        // Liberamos la habitación antes de borrar
        Reserva r = buscarReservaPorCedula(cedula);
        if(r != null) {
             actualizarEstadoHabitacion(r.getHabitacionAsignada(), "Disponible");
        }
        
        String sql = "DELETE FROM reserva WHERE cliente_cedula = ?";
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, cedula);
            return ps.executeUpdate() > 0;
        }
    }
}