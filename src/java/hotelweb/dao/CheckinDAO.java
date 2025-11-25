package hotelweb.dao;

import hotelweb.models.Checkin;
import hotelweb.util.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class CheckinDAO {

    // 1. BUSCAR DATOS (Para hacer Check-in)
    public Checkin buscarDatosPorCedula(String cedula) {
        Checkin datos = null;
        String sql = "SELECT r.*, COALESCE(h.precio, 0) as precio_hab " +
                     "FROM reserva r " +
                     "LEFT JOIN habitaciones h ON r.habitacion_asignada = h.numero " +
                     "WHERE r.cliente_cedula = ? " +
                     "ORDER BY r.idReserva DESC LIMIT 1";

        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, cedula);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    datos = new Checkin();
                    datos.setIdCheckin(0); 
                    
                    datos.setFechaEntrada(rs.getString("fecha_entrada"));
                    datos.setFechaSalida(rs.getString("fecha_salida"));
                    datos.setNumHabitacion(rs.getString("habitacion_asignada"));
                    datos.setTipoHabitacion(rs.getString("tipo_habitacion"));
                    datos.setClienteCedula(rs.getString("cliente_cedula"));
                    datos.setClienteNombre(rs.getString("cliente_nombre"));
                    datos.setClienteApellido(rs.getString("cliente_apellido"));
                    datos.setClienteTelefono(rs.getString("cliente_telefono"));
                    datos.setPrecioNoche(rs.getDouble("precio_hab"));

                    return new Checkin(
                        rs.getString("fecha_entrada"), "14:00",
                        rs.getString("fecha_salida"), "12:00",
                        "", 
                        rs.getString("habitacion_asignada"),
                        rs.getString("tipo_habitacion"),
                        rs.getDouble("precio_hab"), 0.0, 
                        "Pendiente",
                        rs.getString("cliente_cedula"),
                        rs.getString("cliente_nombre"),
                        rs.getString("cliente_apellido"),
                        rs.getString("cliente_telefono"),
                        ""
                    );
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return datos;
    }

    // 2. REGISTRAR NUEVO CHECK-IN
    public boolean registrarCheckin(Checkin c) {
        String sql = "INSERT INTO checkin (fecha_entrada, hora_entrada, fecha_salida, hora_salida, tiempo_estadia, " +
                     "num_habitacion, tipo_habitacion, precio_noche, costo_total, estado_pago, " +
                     "cliente_cedula, cliente_nombre, cliente_apellido, cliente_telefono, observaciones, estado_checkin) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'Activo')";
        
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

            // Marcar habitación como Ocupada
            int filas = ps.executeUpdate();
            if(filas > 0) {
                new HabitacionDAO().cambiarEstadoHabitacion(c.getNumHabitacion(), "Ocupado");
            }
            return filas > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 3. LISTAR SOLO ACTIVOS (Para Check-out y Facturación)
    public List<Checkin> listarCheckinsActivos() {
        List<Checkin> lista = new ArrayList<>();
        String sql = "SELECT * FROM checkin WHERE estado_checkin = 'Activo' ORDER BY id_checkin DESC";
        
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Checkin c = new Checkin();
                c.setIdCheckin(rs.getInt("id_checkin"));
                c.setNumHabitacion(rs.getString("num_habitacion"));
                c.setTipoHabitacion(rs.getString("tipo_habitacion"));
                c.setClienteCedula(rs.getString("cliente_cedula"));
                c.setClienteNombre(rs.getString("cliente_nombre"));
                c.setClienteApellido(rs.getString("cliente_apellido"));
                c.setClienteTelefono(rs.getString("cliente_telefono"));
                c.setFechaEntrada(rs.getString("fecha_entrada"));
                c.setFechaSalida(rs.getString("fecha_salida"));
                c.setCostoTotal(rs.getDouble("costo_total"));
                c.setEstadoPago(rs.getString("estado_pago"));
                c.setPrecioNoche(rs.getDouble("precio_noche"));
                c.setHoraEntrada(rs.getString("hora_entrada"));
                c.setHoraSalida(rs.getString("hora_salida"));
                c.setTiempoEstadia(rs.getString("tiempo_estadia"));
                lista.add(c);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }

    // 4. REALIZAR CHECK-OUT (Finalizar)
    public boolean finalizarCheckin(int idCheckin, String numHabitacion) {
        String fechaHoy = LocalDate.now().format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
        
        String sqlUpdate = "UPDATE checkin SET estado_checkin = 'Finalizado', estado_pago = 'Pagado', fecha_salida_real = ? WHERE id_checkin = ?";
        String sqlLiberar = "UPDATE habitaciones SET estado = 'Disponible' WHERE numero = ?";
        
        Connection con = null;
        try {
            con = ConexionBD.getConnection();
            con.setAutoCommit(false); 

            try (PreparedStatement ps1 = con.prepareStatement(sqlUpdate)) {
                ps1.setString(1, fechaHoy);
                ps1.setInt(2, idCheckin);
                ps1.executeUpdate();
            }

            try (PreparedStatement ps2 = con.prepareStatement(sqlLiberar)) {
                ps2.setString(1, numHabitacion);
                ps2.executeUpdate();
            }

            con.commit();
            return true;
        } catch (SQLException e) {
            try { if(con!=null) con.rollback(); } catch(SQLException ex){}
            e.printStackTrace();
            return false;
        } finally {
            try { if(con!=null) con.setAutoCommit(true); con.close(); } catch(SQLException ex){}
        }
    }
    
    // 5. LISTAR HISTORIAL COMPLETO (Para Reporte ConsultarCheckin.jsp)
    public List<Checkin> listarHistorialCheckins() {
        List<Checkin> lista = new ArrayList<>();
        String sql = "SELECT * FROM checkin ORDER BY id_checkin DESC";
        
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Checkin c = new Checkin();
                c.setIdCheckin(rs.getInt("id_checkin"));
                c.setNumHabitacion(rs.getString("num_habitacion"));
                c.setTipoHabitacion(rs.getString("tipo_habitacion"));
                c.setClienteCedula(rs.getString("cliente_cedula"));
                c.setClienteNombre(rs.getString("cliente_nombre"));
                c.setClienteApellido(rs.getString("cliente_apellido"));
                c.setFechaEntrada(rs.getString("fecha_entrada"));
                c.setFechaSalida(rs.getString("fecha_salida")); 
                
                String real = rs.getString("fecha_salida_real");
                c.setObservaciones((real != null && !real.isEmpty()) ? real : "---"); 
                
                c.setCostoTotal(rs.getDouble("costo_total"));
                c.setEstadoPago(rs.getString("estado_pago"));
                
                try { 
                    String estado = rs.getString("estado_checkin");
                    if(estado != null) c.setTiempoEstadia(estado); 
                    else c.setTiempoEstadia("Activo");
                } catch (Exception e) { c.setTiempoEstadia("Activo"); }

                lista.add(c);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }

    // =============== NUEVOS MÉTODOS PARA FACTURACIÓN ===============

    /**
     * Obtiene un check-in específico por su ID (para Facturación)
     */
    public Checkin obtenerCheckinPorId(int idCheckin) throws SQLException {
        String sql = "SELECT * FROM checkin WHERE id_checkin = ?";
        Checkin checkin = null;

        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idCheckin);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    checkin = new Checkin();
                    checkin.setIdCheckin(rs.getInt("id_checkin"));
                    checkin.setFechaEntrada(rs.getString("fecha_entrada"));
                    checkin.setHoraEntrada(rs.getString("hora_entrada"));
                    checkin.setFechaSalida(rs.getString("fecha_salida"));
                    checkin.setHoraSalida(rs.getString("hora_salida"));
                    checkin.setTiempoEstadia(rs.getString("tiempo_estadia"));
                    checkin.setNumHabitacion(rs.getString("num_habitacion"));
                    checkin.setTipoHabitacion(rs.getString("tipo_habitacion"));
                    checkin.setPrecioNoche(rs.getDouble("precio_noche"));
                    checkin.setCostoTotal(rs.getDouble("costo_total"));
                    checkin.setEstadoPago(rs.getString("estado_pago"));
                    checkin.setClienteCedula(rs.getString("cliente_cedula"));
                    checkin.setClienteNombre(rs.getString("cliente_nombre"));
                    checkin.setClienteApellido(rs.getString("cliente_apellido"));
                    checkin.setClienteTelefono(rs.getString("cliente_telefono"));
                    checkin.setObservaciones(rs.getString("observaciones"));
                }
            }
        }
        return checkin;
    }

    /**
     * Actualiza el estado de pago de un check-in (para Facturación)
     */
    public boolean actualizarEstadoPago(int idCheckin, String estadoPago) throws SQLException {
        String sql = "UPDATE checkin SET estado_pago = ?, estado_checkin = 'Pagado' WHERE id_checkin = ?";
        
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, estadoPago);
            ps.setInt(2, idCheckin);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al actualizar estado de pago: " + e.getMessage());
            throw e;
        }
    }
}