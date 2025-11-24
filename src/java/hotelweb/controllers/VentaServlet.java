package hotelweb.controllers;

import hotelweb.dao.ClienteDAO;
import hotelweb.dao.ProductoDAO;
import hotelweb.models.Cliente;
import hotelweb.models.Producto;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
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
                    // registrarVenta(request, response); 
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