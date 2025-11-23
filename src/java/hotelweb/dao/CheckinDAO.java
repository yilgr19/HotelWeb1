package hotelweb.dao;

import hotelweb.models.Checkin;
import hotelweb.util.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CheckinDAO {

    public Checkin buscarDatosPorCedula(String cedula) {
        Checkin datos = null;
        
        // Buscamos datos de la reserva y el precio de la habitación
        String sql = "SELECT r.*, h.precio " +
                     "FROM reserva r " +
                     "JOIN habitaciones h ON r.habitacion_asignada = h.numero " +
                     "WHERE r.cliente_cedula = ? AND r.estado_reserva = 'Confirmada' " +
                     "ORDER BY r.idReserva DESC LIMIT 1";

        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, cedula);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    datos = new Checkin();
                    // Usamos SETTERS porque las variables son privadas
                    datos.setFechaEntrada(rs.getString("fecha_entrada"));
                    datos.setFechaSalida(rs.getString("fecha_salida"));
                    datos.setNumHabitacion(rs.getString("habitacion_asignada"));
                    datos.setTipoHabitacion(rs.getString("tipo_habitacion"));
                    datos.setClienteCedula(rs.getString("cliente_cedula"));
                    datos.setClienteNombre(rs.getString("cliente_nombre"));
                    datos.setClienteApellido(rs.getString("cliente_apellido"));
                    datos.setClienteTelefono(rs.getString("cliente_telefono"));
                    
                    // CORRECCIÓN DEL ERROR DE LA FOTO 1:
                    // En lugar de datos.idCheckin = 0; usamos:
                    datos.setIdCheckin(0); 
                    
                    // CORRECCIÓN DEL CONSTRUCTOR (Debe tener 15 parámetros en orden)
                    return new Checkin(
                        rs.getString("fecha_entrada"), // 1
                        "14:00",                       // 2 (Hora entrada default)
                        rs.getString("fecha_salida"),  // 3
                        "12:00",                       // 4 (Hora salida default)
                        "",                            // 5 (Tiempo estadía, se calcula después)
                        rs.getString("habitacion_asignada"), // 6
                        rs.getString("tipo_habitacion"),     // 7
                        rs.getDouble("precio"),        // 8 (Precio Noche)
                        0.0,                           // 9 (Total, se calcula después)
                        "Pendiente",                   // 10
                        rs.getString("cliente_cedula"),   // 11
                        rs.getString("cliente_nombre"),   // 12
                        rs.getString("cliente_apellido"), // 13
                        rs.getString("cliente_telefono"), // 14
                        ""                                // 15 (Observaciones vacías)
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return datos;
    }

    public boolean registrarCheckin(Checkin c) {
        String sql = "INSERT INTO checkin (fecha_entrada, hora_entrada, fecha_salida, hora_salida, tiempo_estadia, " +
                     "num_habitacion, tipo_habitacion, precio_noche, costo_total, estado_pago, " +
                     "cliente_cedula, cliente_nombre, cliente_apellido, cliente_telefono, observaciones) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, c.getFechaEntrada());
            ps.setString(2, c.getHoraEntrada());
            ps.setString(3, c.getFechaSalida());
            ps.setString(4, c.getHoraSalida());
            ps.setString(5, c.getTiempoEstadia());
            ps.setString(6, c.getNumHabitacion());
            ps.setString(7, c.getTipoHabitacion());
            ps.setDouble(8, c.getPrecioNoche());
            ps.setDouble(9, c.getCostoTotal());
            ps.setString(10, c.getEstadoPago());
            ps.setString(11, c.getClienteCedula());
            ps.setString(12, c.getClienteNombre());
            ps.setString(13, c.getClienteApellido());
            ps.setString(14, c.getClienteTelefono());
            ps.setString(15, c.getObservaciones());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}