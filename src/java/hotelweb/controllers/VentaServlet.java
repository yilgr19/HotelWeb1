package hotelweb.controllers;

import hotelweb.dao.ClienteDAO;
import hotelweb.dao.ProductoDAO;
import hotelweb.dao.VentaDAO;
import hotelweb.models.Cliente;
import hotelweb.models.Producto;
import hotelweb.models.Venta;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class VentaServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        if (accion != null) {
            switch (accion) {
                case "buscarCliente":
                    buscarCliente(request, response);
                    break;
                case "buscarProducto":
                    buscarProducto(request, response);
                    break;
                case "registrarVenta":
                    registrarVenta(request, response);
                    break;
                default:
                    request.getRequestDispatcher("NuevaVenta.jsp").forward(request, response);
            }
        } else {
            request.getRequestDispatcher("NuevaVenta.jsp").forward(request, response);
        }
    }

    private void buscarCliente(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/plain;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String cedula = request.getParameter("cedula");
        
        if (cedula == null || cedula.trim().isEmpty()) { 
            out.write("NO_ENCONTRADO"); 
            return; 
        }
        
        try {
            ClienteDAO dao = new ClienteDAO();
            Cliente c = dao.buscarPorCedula(cedula);
            if (c != null) {
                out.write(c.getIdCliente() + "|" + c.getNombre() + "|" + c.getApellido() + "|" + c.getTelefono() + "|" + c.getDireccion() + "|" + c.getCorreo());
            } else {
                out.write("NO_ENCONTRADO");
            }
        } catch (Exception e) {
            out.write("ERROR_DB");
            System.err.println("Error buscando cliente: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
   private void buscarProducto(HttpServletRequest request, HttpServletResponse response) throws IOException {
    response.setContentType("text/plain;charset=UTF-8");
    PrintWriter out = response.getWriter();
    String codigo = request.getParameter("codigo");
    
    if (codigo == null || codigo.trim().isEmpty()) { 
        out.write("ERROR_CODIGO"); 
        return; 
    }

    try {
        ProductoDAO dao = new ProductoDAO();
        Producto p = dao.buscarProductoPorCodigo(codigo);

        if (p != null) {
            String respuesta = p.getIdProducto() + "|" + 
                               p.getNombre() + "|" + 
                               p.getPrecio() + "|" + 
                               p.getImpuesto() + "|" + 
                               p.getExistencia();
            out.write(respuesta);
        } else {
            out.write("NO_ENCONTRADO");
        }
    } catch (Exception e) {
        out.write("ERROR_DB");
        System.err.println("Error buscando producto: " + e.getMessage());
        e.printStackTrace();
    }
}

    private void registrarVenta(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            System.out.println("=== INICIANDO REGISTRO DE VENTA ===");
            
            String cedulaCliente = request.getParameter("cedulaCliente");
            String nombreCliente = request.getParameter("nombreCliente");
            String metodoPago = request.getParameter("metodoPago");
            String totalVentaStr = request.getParameter("totalVenta");
            String productosJSON = request.getParameter("productos");
            
            System.out.println("Cédula: " + cedulaCliente);
            System.out.println("Cliente: " + nombreCliente);
            System.out.println("Método Pago: " + metodoPago);
            System.out.println("Total: " + totalVentaStr);
            System.out.println("Productos: " + productosJSON);
            
            if (cedulaCliente == null || cedulaCliente.trim().isEmpty()) {
                out.write("{\"exito\": false, \"mensaje\": \"Cédula del cliente requerida\"}");
                return;
            }
            if (productosJSON == null || productosJSON.trim().isEmpty()) {
                out.write("{\"exito\": false, \"mensaje\": \"No hay productos en la venta\"}");
                return;
            }
            
            VentaDAO ventaDAOTemp = new VentaDAO();
            String numeroFactura = ventaDAOTemp.generarNumeroFactura();
            System.out.println("Factura generada: " + numeroFactura);
            
            double totalVenta = (totalVentaStr != null && !totalVentaStr.isEmpty()) ? Double.parseDouble(totalVentaStr) : 0;
            
            SimpleDateFormat sdfFecha = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat sdfHora = new SimpleDateFormat("HH:mm:ss");
            String fecha = sdfFecha.format(new Date());
            String hora = sdfHora.format(new Date());

            System.out.println("Fecha: " + fecha + " Hora: " + hora);

            Venta venta = new Venta(numeroFactura, fecha, hora, cedulaCliente, 
                                    nombreCliente != null ? nombreCliente : "Cliente", 
                                    metodoPago != null ? metodoPago : "Efectivo",
                                    0, 0, totalVenta);

            VentaDAO ventaDAO = new VentaDAO();
            boolean ventaRegistrada = ventaDAO.registrarVenta(venta);

            if (!ventaRegistrada) {
                System.err.println("No se pudo registrar la venta en BD");
                out.write("{\"exito\": false, \"mensaje\": \"Error al registrar la venta\"}");
                return;
            }

            System.out.println("✓ Venta registrada exitosamente");

            System.out.println("Procesando actualización de stock...");
            
            try {
                ProductoDAO productoDAO = new ProductoDAO();
                
                String jsonLimpio = productosJSON.replace("[", "").replace("]", "").trim();
                String[] objetos = jsonLimpio.split("\\}\\s*,\\s*\\{");
                
                for (String objeto : objetos) {
                    objeto = objeto.replace("{", "").replace("}", "").trim();
                    if (objeto.isEmpty()) continue;
                    
                    Pattern patternId = Pattern.compile("\"id\"\\s*:\\s*\"?(\\d+)\"?");
                    Matcher matcherId = patternId.matcher(objeto);
                    
                    Pattern patternCant = Pattern.compile("\"cantidad\"\\s*:\\s*(\\d+)");
                    Matcher matcherCant = patternCant.matcher(objeto);
                    
                    if (matcherId.find() && matcherCant.find()) {
                        int idProducto = Integer.parseInt(matcherId.group(1));
                        int cantidad = Integer.parseInt(matcherCant.group(1));
                        
                        System.out.println("Actualizando stock - Producto ID: " + idProducto + ", Cantidad: " + cantidad);
                        productoDAO.actualizarStock(idProducto, cantidad);
                        System.out.println("✓ Stock actualizado");
                    }
                }
                
                System.out.println("✓ Stocks actualizados exitosamente");
            } catch (Exception e) {
                System.err.println("Error al actualizar stock: " + e.getMessage());
                e.printStackTrace();
            }

            System.out.println("=== VENTA COMPLETADA EXITOSAMENTE ===\n");
            out.write("{\"exito\": true, \"mensaje\": \"Venta registrada exitosamente\", \"factura\": \"" + numeroFactura + "\"}");

        } catch (NumberFormatException e) {
            System.err.println("ERROR DE FORMATO: " + e.getMessage());
            e.printStackTrace();
            out.write("{\"exito\": false, \"mensaje\": \"Error en formato de datos\"}");
        } catch (Exception e) {
            System.err.println("ERROR CRÍTICO: " + e.getMessage());
            e.printStackTrace();
            out.write("{\"exito\": false, \"mensaje\": \"Error: " + e.getMessage() + "\"}");
        }
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