// Ubicación: hotelweb.controllers.ProductoServlet

package hotelweb.controllers;

import hotelweb.dao.ProductoDAO;
import hotelweb.models.Producto;
import hotelweb.models.Usuario;
import java.io.IOException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ProductoServlet", urlPatterns = {"/ProductoServlet"})
public class ProductoServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Asegurar la codificación de caracteres para los datos del formulario (acentos/ñ)
        request.setCharacterEncoding("UTF-8");

        // 2. Obtener la acción del formulario
        String accion = request.getParameter("accion");

        if (accion != null && accion.equals("guardar")) {
            guardarProducto(request, response);
        } else {
            // Manejar otras acciones o error
            response.sendRedirect("Menu.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
    
    // --- Lógica para guardar el producto ---
    private void guardarProducto(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        // Validar sesión antes de procesar (aunque el JSP ya lo hace [cite: 2])
        Usuario usuarioLogueado = (Usuario) request.getSession().getAttribute("usuarioLogueado");
        if (usuarioLogueado == null) {
            response.sendRedirect("index.jsp?error=sesion_expirada");
            return;
        }

        try {
            // 1. Recibir y parsear todos los parámetros del formulario (RegistrarProductos.jsp)
            String codigo = request.getParameter("codigo");             // [cite: 19]
            String nombre = request.getParameter("nombre");             // [cite: 20]
            String descripcion = request.getParameter("descripcion");   // [cite: 25]
            
            // Los campos numéricos y fecha deben parsearse/validarse
            int idCategoria = Integer.parseInt(request.getParameter("idCategoria")); // [cite: 22]
            double precioBase = Double.parseDouble(request.getParameter("precio"));   // [cite: 28]
            double impuesto = Double.parseDouble(request.getParameter("impuesto"));   // [cite: 30]
            int existencia = Integer.parseInt(request.getParameter("existencia"));   // [cite: 33]
            
            String fechaVencimientoStr = request.getParameter("fechaVencimiento"); // [cite: 35]
            Date fechaVencimiento = null;

            // Manejar la fecha opcional (si se ingresó)
            if (fechaVencimientoStr != null && !fechaVencimientoStr.isEmpty()) {
                fechaVencimiento = Date.valueOf(fechaVencimientoStr);
            }

            // 2. Crear el objeto Producto
            Producto nuevoProducto = new Producto(
                codigo, 
                nombre, 
                descripcion, 
                idCategoria, 
                precioBase, 
                impuesto, 
                existencia, 
                fechaVencimiento
            );

            // 3. Llamar al DAO para la inserción
            ProductoDAO dao = new ProductoDAO();
            boolean guardado = dao.guardarProducto(nuevoProducto);

            // 4. Redireccionar con mensaje de éxito o error
            if (guardado) {
                request.setAttribute("mensaje", "✅ Producto **" + nombre + "** guardado con éxito.");
            } else {
                request.setAttribute("error", "❌ No se pudo guardar el producto. Intente de nuevo.");
            }
            
        } catch (NumberFormatException e) {
            // Manejar error si el usuario envía datos no numéricos en campos 'int' o 'double'
            request.setAttribute("error", "❌ Error de formato en los números. Revise los campos de Precio, IVA y Existencia.");
        } catch (Exception e) {
            // Manejar cualquier otro error inesperado (ej. error de DB)
            System.err.println("Error general al procesar el producto: " + e.getMessage());
            request.setAttribute("error", "❌ Ocurrió un error inesperado al guardar el producto.");
        }

        // Reenvía al mismo JSP para mostrar el mensaje de resultado (éxito o error) [cite: 15, 17]
        request.getRequestDispatcher("RegistrarProductos.jsp").forward(request, response);
    }
}