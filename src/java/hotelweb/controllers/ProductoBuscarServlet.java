package hotelweb.controllers;

import hotelweb.dao.ProductoDAO;
import hotelweb.models.Producto;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ProductoBuscarServlet", urlPatterns = {"/ProductoBuscarServlet"})
public class ProductoBuscarServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/plain;charset=UTF-8");
        
        String codigo = request.getParameter("codigo");
        
        if (codigo == null || codigo.trim().isEmpty()) {
            response.getWriter().write("NO_ENCONTRADO");
            return;
        }

        try {
            ProductoDAO productoDAO = new ProductoDAO();
            Producto producto = productoDAO.buscarProductoPorCodigo(codigo);

            if (producto != null) {
                String respuesta = producto.getIdProducto() + "|" + 
                                   producto.getNombre() + "|" + 
                                   producto.getPrecio() + "|" + 
                                   producto.getImpuesto() + "|" + 
                                   producto.getExistencia();
                response.getWriter().write(respuesta);
            } else {
                response.getWriter().write("NO_ENCONTRADO");
            }
            
        } catch (SQLException e) {
            System.err.println("Error SQL al buscar producto: " + e.getMessage());
            e.printStackTrace();
            response.getWriter().write("ERROR_DB");
        } catch (Exception e) {
            System.err.println("Error general: " + e.getMessage());
            e.printStackTrace();
            response.getWriter().write("ERROR");
        }
    }
}