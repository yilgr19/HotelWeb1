package hotelweb.controllers;

import hotelweb.dao.*;
import hotelweb.models.*;
import hotelweb.util.ConexionBD;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ReportesServlet", urlPatterns = {"/ReportesServlet"})
public class ReportesServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Verificar sesión
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuarioLogueado") == null) {
            response.sendRedirect("index.jsp?error=sesion_expirada");
            return;
        }
        
        Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");
        
        // Verificar que sea administrador
        if (!usuarioLogueado.getRol().equals("Administrador")) {
            response.sendRedirect("Menu.jsp?error=acceso_denegado");
            return;
        }
        
        Connection conexion = null;
        
        try {
            // Obtener conexión
            conexion = ConexionBD.getConnection();
            
            // Obtener todos los datos
            List<Cliente> listaClientes = obtenerClientes(conexion);
            List<Habitacion> listaHabitaciones = obtenerHabitaciones(conexion);
            List<Reserva> listaReservas = obtenerReservas(conexion);
            List<Checkin> listaCheckins = obtenerCheckins(conexion);
            List<Producto> listaProductos = obtenerProductos(conexion);
            List<Venta> listaVentas = obtenerVentas(conexion);
            
            // Enviar datos al JSP
            request.setAttribute("listaClientes", listaClientes);
            request.setAttribute("listaHabitaciones", listaHabitaciones);
            request.setAttribute("listaReservas", listaReservas);
            request.setAttribute("listaCheckins", listaCheckins);
            request.setAttribute("listaProductos", listaProductos);
            request.setAttribute("listaVentas", listaVentas);
            
            // Redirigir al JSP
            request.getRequestDispatcher("Reportes.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("Menu.jsp?error=error_reportes");
        } finally {
            if (conexion != null) {
                try {
                    conexion.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
    
    // Método para obtener clientes
    private List<Cliente> obtenerClientes(Connection conexion) {
        List<Cliente> lista = new ArrayList<>();
        String sql = "SELECT * FROM cliente ORDER BY idCliente DESC";
        
        try (PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Cliente c = new Cliente();
                c.setIdCliente(rs.getInt("idCliente"));
                c.setCedula(rs.getString("cedula"));
                c.setNombre(rs.getString("nombre"));
                c.setApellido(rs.getString("apellido"));
                c.setTelefono(rs.getString("telefono"));
                c.setDireccion(rs.getString("direccion"));
                c.setCorreo(rs.getString("correo"));
                lista.add(c);
            }
            System.out.println("Clientes obtenidos: " + lista.size());
        } catch (Exception e) {
            System.err.println("Error al obtener clientes: " + e.getMessage());
            e.printStackTrace();
        }
        
        return lista;
    }
    
    // Método para obtener habitaciones
    private List<Habitacion> obtenerHabitaciones(Connection conexion) {
        List<Habitacion> lista = new ArrayList<>();
        String sql = "SELECT * FROM habitaciones ORDER BY id_habitacion";
        
        try (PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Habitacion h = new Habitacion();
                h.setIdHabitacion(rs.getInt("id_habitacion"));
                h.setNumero(rs.getString("numero"));
                h.setTipo(rs.getString("tipo"));
                h.setPrecio(rs.getDouble("precio"));
                h.setEstado(rs.getString("estado"));
                lista.add(h);
            }
            System.out.println("Habitaciones obtenidas: " + lista.size());
        } catch (Exception e) {
            System.err.println("Error al obtener habitaciones: " + e.getMessage());
            e.printStackTrace();
        }
        
        return lista;
    }
    
    // Método para obtener reservas
    private List<Reserva> obtenerReservas(Connection conexion) {
        List<Reserva> lista = new ArrayList<>();
        String sql = "SELECT * FROM reserva ORDER BY idReserva DESC";
        
        try (PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Reserva r = new Reserva();
                r.setIdReserva(rs.getInt("idReserva"));
                r.setFechaEntrada(rs.getString("fecha_entrada"));
                r.setHoraEntrada(rs.getString("hora_entrada"));
                r.setFechaSalida(rs.getString("fecha_salida"));
                r.setHoraSalida(rs.getString("hora_salida"));
                r.setTipoHabitacion(rs.getString("tipo_habitacion"));
                r.setNumHuespedes(rs.getInt("num_huespedes"));
                r.setHabitacionAsignada(rs.getString("habitacion_asignada"));
                r.setMetodoPago(rs.getString("metodo_pago"));
                r.setEstadoReserva(rs.getString("estado_reserva"));
                r.setCedulaCliente(rs.getString("cliente_cedula"));
                r.setClienteNombre(rs.getString("cliente_nombre"));
                r.setClienteApellido(rs.getString("cliente_apellido"));
                r.setClienteTelefono(rs.getString("cliente_telefono"));
                lista.add(r);
            }
            System.out.println("Reservas obtenidas: " + lista.size());
        } catch (Exception e) {
            System.err.println("Error al obtener reservas: " + e.getMessage());
            e.printStackTrace();
        }
        
        return lista;
    }
    
    // Método para obtener check-ins
    private List<Checkin> obtenerCheckins(Connection conexion) {
        List<Checkin> lista = new ArrayList<>();
        String sql = "SELECT * FROM checkin ORDER BY id_checkin DESC";
        
        try (PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Checkin ch = new Checkin();
                ch.setIdCheckin(rs.getInt("id_checkin"));
                ch.setFechaEntrada(rs.getString("fecha_entrada"));
                ch.setHoraEntrada(rs.getString("hora_entrada"));
                ch.setFechaSalida(rs.getString("fecha_salida"));
                ch.setHoraSalida(rs.getString("hora_salida"));
                ch.setTiempoEstadia(rs.getString("tiempo_estadia"));
                ch.setNumHabitacion(rs.getString("num_habitacion"));
                ch.setTipoHabitacion(rs.getString("tipo_habitacion"));
                ch.setPrecioNoche(rs.getDouble("precio_noche"));
                ch.setCostoTotal(rs.getDouble("costo_total"));
                ch.setEstadoPago(rs.getString("estado_pago"));
                ch.setClienteCedula(rs.getString("cliente_cedula"));
                ch.setClienteNombre(rs.getString("cliente_nombre"));
                ch.setClienteApellido(rs.getString("cliente_apellido"));
                ch.setClienteTelefono(rs.getString("cliente_telefono"));
                ch.setObservaciones(rs.getString("observaciones"));
                lista.add(ch);
            }
            System.out.println("Check-ins obtenidos: " + lista.size());
        } catch (Exception e) {
            System.err.println("Error al obtener check-ins: " + e.getMessage());
            e.printStackTrace();
        }
        
        return lista;
    }
    
    // Método para obtener productos
    private List<Producto> obtenerProductos(Connection conexion) {
        List<Producto> lista = new ArrayList<>();
        String sql = "SELECT * FROM productos ORDER BY id_producto";
        
        try (PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Producto p = new Producto();
                p.setIdProducto(rs.getInt("id_producto"));
                p.setCodigo(rs.getString("codigo"));
                p.setNombre(rs.getString("nombre"));
                p.setDescripcion(rs.getString("descripcion"));
                p.setIdCategoria(rs.getInt("id_categoria"));
                p.setPrecio(rs.getDouble("precio"));
                p.setImpuesto(rs.getDouble("impuesto"));
                p.setExistencia(rs.getInt("existencia"));
                p.setFechaVencimiento(rs.getDate("fecha_vencimiento"));
                lista.add(p);
            }
            System.out.println("Productos obtenidos: " + lista.size());
        } catch (Exception e) {
            System.err.println("Error al obtener productos: " + e.getMessage());
            e.printStackTrace();
        }
        
        return lista;
    }
    
    // Método para obtener ventas
    private List<Venta> obtenerVentas(Connection conexion) {
        List<Venta> lista = new ArrayList<>();
        String sql = "SELECT * FROM ventas ORDER BY id_venta DESC";
        
        try (PreparedStatement ps = conexion.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Venta v = new Venta();
                v.setIdVenta(rs.getInt("id_venta"));
                v.setNumeroFactura(rs.getString("num_factura"));
                v.setFecha(rs.getString("fecha"));
                v.setHora(rs.getString("hora"));
                v.setCedulaCliente(rs.getString("cedula_cliente"));
                v.setNombreCliente(rs.getString("nombre_cliente"));
                v.setMetodoPago(rs.getString("metodo_pago"));
                v.setSubtotal(rs.getDouble("subtotal"));
                v.setIvaTotal(rs.getDouble("iva_total"));
                v.setTotalVenta(rs.getDouble("total_venta"));
                lista.add(v);
            }
            System.out.println("Ventas obtenidas: " + lista.size());
        } catch (Exception e) {
            System.err.println("Error al obtener ventas: " + e.getMessage());
            e.printStackTrace();
        }
        
        return lista;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}