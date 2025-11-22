package hotelweb.dao;

import hotelweb.models.Reserva;
import hotelweb.util.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ReservaDAO {

    public boolean registrarReserva(Reserva reserva) throws SQLException {
        String sql = "INSERT INTO reserva (fecha_entrada, hora_entrada, fecha_salida, hora_salida, "
                   + "tipo_habitacion, num_huespedes, habitacion_asignada, metodo_pago, "
                   + "estado_reserva, cliente_cedula) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
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
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error SQL al reservar: " + e.getMessage());
            throw e; 
        }
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
                        rs.getString("cliente_cedula")
                    );
                }
            }
        }
        return reserva;
    }

    public boolean eliminarReservaPorCedula(String cedula) throws SQLException {
        String sql = "DELETE FROM reserva WHERE cliente_cedula = ?";
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, cedula);
            return ps.executeUpdate() > 0;
        }
    }
}