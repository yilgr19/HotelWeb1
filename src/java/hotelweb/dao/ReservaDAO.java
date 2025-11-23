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
            
            // DATOS DEL CLIENTE
            ps.setString(11, reserva.getClienteNombre());
            ps.setString(12, reserva.getClienteApellido());
            ps.setString(13, reserva.getClienteTelefono());
            
            int filas = ps.executeUpdate();
            
            // Actualizar estado de habitación a 'Ocupado'
            if(filas > 0) {
                new HabitacionDAO().cambiarEstadoHabitacion(reserva.getHabitacionAsignada(), "Ocupado");
            }
            return filas > 0;
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
                    // AQUÍ ESTABA EL ERROR: AHORA SÍ LEEMOS LOS DATOS
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
                        // Leemos las columnas que faltaban
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
        // Primero buscamos para liberar la habitación
        Reserva r = buscarReservaPorCedula(cedula);
        if(r != null) {
             new HabitacionDAO().cambiarEstadoHabitacion(r.getHabitacionAsignada(), "Disponible");
        }
        
        String sql = "DELETE FROM reserva WHERE cliente_cedula = ?";
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, cedula);
            return ps.executeUpdate() > 0;
        }
    }
    public java.util.List<Reserva> listarReservas() {
        java.util.List<Reserva> lista = new java.util.ArrayList<>();
        String sql = "SELECT * FROM reserva ORDER BY idReserva DESC"; // Las más recientes primero
        
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Reserva r = new Reserva(
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
                    rs.getString("cliente_nombre"),
                    rs.getString("cliente_apellido"),
                    rs.getString("cliente_telefono")
                );
                lista.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}