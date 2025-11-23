package hotelweb.controllers;

import hotelweb.dao.VentaDAO;
import hotelweb.models.DetalleVenta;
import hotelweb.models.Venta;
import hotelweb.models.Producto;
import hotelweb.models.Cliente; 
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "VentaServlet", urlPatterns = {"/VentaServlet"})
public class VentaServlet extends HttpServlet {

    // 🛑 MÉTODO MODIFICADO: doGet (Maneja ambas búsquedas AJAX)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        VentaDAO dao = new VentaDAO();
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        // 1. Lógica de búsqueda de producto
        if ("buscar_producto_ajax".equalsIgnoreCase(accion)) {
            String codigo = request.getParameter("codigo");
            Producto p = dao.buscarProductoPorCodigo(codigo);
            
            if (p != null) {
                String json = "{\"codigo\":\"" + p.getCodigo() + "\", "
                            + "\"nombre\":\"" + p.getNombre() + "\", "
                            + "\"precio\":" + p.getPrecio() + ", "
                            + "\"impuesto\":" + p.getImpuesto() + ", "
                            + "\"existencia\":" + p.getExistencia() + "}";
                response.getWriter().write(json);
            } else {
                response.getWriter().write("{\"error\":\"Producto con código " + codigo + " no encontrado.\"}");
            }
            return; 
        } 
        
        // 🛑 LÓGICA NUEVA: BÚSQUEDA DE CLIENTE POR CÉDULA
        else if ("buscar_cliente_ajax".equalsIgnoreCase(accion)) {
            String cedula = request.getParameter("cedula");
            Cliente cliente = dao.buscarClientePorCedula(cedula);
            
            if (cliente != null) {
                // Cliente encontrado: Concatena nombre y apellido
                String nombreCompleto = cliente.getNombre() + " " + cliente.getApellido();
                String json = "{\"nombre\":\"" + nombreCompleto + "\", \"found\":true}";
                response.getWriter().write(json);
            } else {
                // Cliente no encontrado
                response.getWriter().write("{\"nombre\":\"\", \"found\":false}");
            }
            return;
        }
        
        // Si no es ninguna acción AJAX, redirige
        response.sendRedirect("NuevaVenta.jsp");
    }

    // MÉTODO doPost (Debe asegurar que la venta se asocie a un cliente válido)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        VentaDAO dao = new VentaDAO();

        try {
            if ("guardar_venta".equalsIgnoreCase(accion)) {
                
                String cedula = request.getParameter("cedula").trim();
                String nombre = request.getParameter("nombre").trim(); // Este nombre ya es el Nombre Completo
                String metodoPago = request.getParameter("metodoPago");
                
                // 🛑 VALIDACIÓN CLAVE: Datos del Cliente Obligatorios
                if (cedula.isEmpty() || nombre.isEmpty()) {
                    request.setAttribute("error", "Debe ingresar una **Cédula** y un **Nombre de Cliente** válido para asociar la venta.");
                    request.getRequestDispatcher("NuevaVenta.jsp").forward(request, response);
                    return;
                }

                String fecha = LocalDate.now().toString();
                String hora = LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm"));
                String numFactura = dao.generarNumeroFactura(); 
                
                // 2. Recoger arrays de la tabla
                String[] codigos = request.getParameterValues("tblCodigo");
                String[] nombres = request.getParameterValues("tblNombre");
                String[] cantidades = request.getParameterValues("tblCantidad");
                String[] precios = request.getParameterValues("tblPrecio");
                String[] subtotales = request.getParameterValues("tblSubtotal"); // Contiene Base + IVA

                if (codigos == null || codigos.length == 0) {
                    request.setAttribute("error", "No hay productos en la venta. Agregue al menos un producto.");
                    request.getRequestDispatcher("NuevaVenta.jsp").forward(request, response);
                    return;
                }

                // 3. Armar lista de detalles
                List<DetalleVenta> detalles = new ArrayList<>();
                for (int i = 0; i < codigos.length; i++) {
                    detalles.add(new DetalleVenta(
                        codigos[i],
                        nombres[i],
                        Integer.parseInt(cantidades[i]),
                        Double.parseDouble(precios[i]),
                        Double.parseDouble(subtotales[i])
                    ));
                }

                // 4. Obtener totales finales del formulario
                double totalVenta = Double.parseDouble(request.getParameter("total"));
                double ivaTotal = Double.parseDouble(request.getParameter("ivaTotal"));
                double subtotal = Double.parseDouble(request.getParameter("subtotal")); // Base sin IVA

                // 5. Crear objeto Venta (Asegúrate de que el constructor de Venta acepte 'nombre' como nombre completo)
                Venta nuevaVenta = new Venta(numFactura, fecha, hora, cedula, nombre, metodoPago, subtotal, ivaTotal, totalVenta, detalles);
                
                // 6. Guardar en BD
                if (dao.registrarVenta(nuevaVenta)) {
                    request.setAttribute("ventaExitosa", nuevaVenta);
                    // ÉXITO: Redirigimos a la factura
                    request.getRequestDispatcher("FacturaVenta.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Error al registrar la venta en BD. Revise la conexión o el stock.");
                    request.getRequestDispatcher("NuevaVenta.jsp").forward(request, response);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error inesperado al procesar la venta: " + e.getMessage());
            request.getRequestDispatcher("NuevaVenta.jsp").forward(request, response);
        }
    }
}