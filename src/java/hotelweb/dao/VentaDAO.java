// Ubicación: hotelweb.dao.VentaDAO

package hotelweb.dao;

import hotelweb.models.Venta;
import hotelweb.util.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

public class VentaDAO {

    /**
     * Genera el siguiente número de factura (ej. F000001)
     */
    public String generarNumeroFactura() {
        String serie = "F";
        int numero = 0;
        String sql = "SELECT MAX(CAST(SUBSTR(num_factura, 2) AS UNSIGNED)) AS max_numero FROM ventas";
        
        try (Connection con = ConexionBD.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next() && rs.getString("max_numero") != null) {
                numero = rs.getInt("max_numero") + 1;
            } else {
                numero = 1;
            }
            
            return serie + String.format("%06d", numero);
            
        } catch (SQLException e) {
            System.err.println("Error al generar número de factura: " + e.getMessage());
            e.printStackTrace();
            return "ERROR_0000"; 
        }
    }

    /**
     * Registra una nueva venta en la tabla 'ventas'
     */
    public boolean registrarVenta(Venta venta) {
        String sql = "INSERT INTO ventas (num_factura, fecha, hora, cedula_cliente, nombre_cliente, metodo_pago, subtotal, iva_total, total_venta) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = ConexionBD.getConnection();
            ps = con.prepareStatement(sql);
            
            ps.setString(1, venta.getNumeroFactura());
            ps.setString(2, venta.getFecha());
            ps.setString(3, venta.getHora());
            ps.setString(4, venta.getCedulaCliente());
            ps.setString(5, venta.getNombreCliente());
            ps.setString(6, venta.getMetodoPago());
            ps.setDouble(7, venta.getSubtotal());
            ps.setDouble(8, venta.getIvaTotal());
            ps.setDouble(9, venta.getTotalVenta());
            
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
            
        } catch (SQLException e) {
            System.err.println("Error al registrar venta: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                System.err.println("Error al cerrar: " + ex.getMessage());
            }
        }
    }

    /**
     * Obtiene todas las ventas ordenadas por fecha descendente
     */
    public List<Venta> obtenerTodasLasVentas() {
        List<Venta> ventas = new ArrayList<>();
        String sql = "SELECT id_venta, num_factura, fecha, cedula_cliente, nombre_cliente, metodo_pago, total_venta " +
                     "FROM ventas ORDER BY fecha DESC";
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = ConexionBD.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Venta venta = new Venta();
                venta.setIdVenta(rs.getInt("id_venta"));
                venta.setNumeroFactura(rs.getString("num_factura"));
                venta.setFecha(rs.getString("fecha"));
                venta.setCedulaCliente(rs.getString("cedula_cliente"));
                venta.setNombreCliente(rs.getString("nombre_cliente"));
                venta.setMetodoPago(rs.getString("metodo_pago"));
                venta.setTotalVenta(rs.getDouble("total_venta"));
                
                ventas.add(venta);
            }
            
        } catch (SQLException e) {
            System.err.println("Error obteniendo ventas: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                System.err.println("Error al cerrar: " + ex.getMessage());
            }
        }
        
        return ventas;
    }

    /**
     * Busca ventas por rango de fechas
     */
    public List<Venta> buscarVentasPorFecha(String fechaIni, String fechaFin) {
        List<Venta> ventas = new ArrayList<>();
        String sql = "SELECT id_venta, num_factura, fecha, cedula_cliente, nombre_cliente, metodo_pago, total_venta " +
                     "FROM ventas WHERE 1=1";
        
        if (fechaIni != null && !fechaIni.isEmpty()) {
            sql += " AND fecha >= ?";
        }
        if (fechaFin != null && !fechaFin.isEmpty()) {
            sql += " AND fecha <= ?";
        }
        
        sql += " ORDER BY fecha DESC";
        
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = ConexionBD.getConnection();
            ps = con.prepareStatement(sql);
            
            int index = 1;
            if (fechaIni != null && !fechaIni.isEmpty()) {
                ps.setString(index++, fechaIni);
            }
            if (fechaFin != null && !fechaFin.isEmpty()) {
                ps.setString(index++, fechaFin);
            }
            
            rs = ps.executeQuery();

            while (rs.next()) {
                Venta venta = new Venta();
                venta.setIdVenta(rs.getInt("id_venta"));
                venta.setNumeroFactura(rs.getString("num_factura"));
                venta.setFecha(rs.getString("fecha"));
                venta.setCedulaCliente(rs.getString("cedula_cliente"));
                venta.setNombreCliente(rs.getString("nombre_cliente"));
                venta.setMetodoPago(rs.getString("metodo_pago"));
                venta.setTotalVenta(rs.getDouble("total_venta"));
                
                ventas.add(venta);
            }
            
        } catch (SQLException e) {
            System.err.println("Error buscando ventas: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                System.err.println("Error al cerrar: " + ex.getMessage());
            }
        }
        
        return ventas;
    }

    /**
     * Anula una venta por su ID
     */
    public boolean anularVenta(int idVenta) {
        String sql = "UPDATE ventas SET estado = 'Anulada' WHERE id_venta = ?";
        
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = ConexionBD.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idVenta);
            
            int filasAfectadas = ps.executeUpdate();
            return filasAfectadas > 0;
            
        } catch (SQLException e) {
            System.err.println("Error anulando venta: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                System.err.println("Error al cerrar: " + ex.getMessage());
            }
        }
    }
}