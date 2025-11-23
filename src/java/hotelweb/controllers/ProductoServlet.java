package hotelweb.controllers;

import hotelweb.dao.ProductoDAO;
import hotelweb.models.Producto;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ProductoServlet", urlPatterns = {"/ProductoServlet"})
public class ProductoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        ProductoDAO dao = new ProductoDAO();
        
        try {
            if ("guardar".equalsIgnoreCase(accion)) {
                String codigo = request.getParameter("codigo");
                String nombre = request.getParameter("nombre");
                String descripcion = request.getParameter("descripcion");
                String fechaVencimiento = request.getParameter("fechaVencimiento"); // NUEVO
                
                int idCategoria = 1; // Default
                double precio = 0;
                double impuesto = 0;
                int existencia = 0;
                
                try {
                    idCategoria = Integer.parseInt(request.getParameter("idCategoria")); // NUEVO
                    precio = Double.parseDouble(request.getParameter("precio"));
                    impuesto = Double.parseDouble(request.getParameter("impuesto"));
                    existencia = Integer.parseInt(request.getParameter("existencia"));
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Error en campos numéricos.");
                    request.getRequestDispatcher("RegistrarProductos.jsp").forward(request, response);
                    return;
                }

                // Creamos objeto con todos los datos
                Producto nuevoProducto = new Producto(codigo, nombre, descripcion, idCategoria, precio, impuesto, existencia, fechaVencimiento);
                
                if (dao.registrarProducto(nuevoProducto)) {
                    request.setAttribute("mensaje", "Producto registrado correctamente.");
                } else {
                    request.setAttribute("error", "Error al guardar (Código duplicado o datos inválidos).");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error del sistema: " + e.getMessage());
        }
        
        request.getRequestDispatcher("RegistrarProductos.jsp").forward(request, response);
    }
}