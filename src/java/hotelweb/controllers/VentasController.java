package hotelweb.controllers;

import hotelweb.dao.VentaDAO;
import hotelweb.models.Venta;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "VentasController", urlPatterns = {"/VentasController"})
public class VentasController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if (action == null || action.equals("listar")) {
            listarVentas(request, response);
        } else if (action.equals("buscar")) {
            buscarVentas(request, response);
        } else if (action.equals("anular")) {
            anularVenta(request, response);
        } else {
            listarVentas(request, response);
        }
    }

    private void listarVentas(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            VentaDAO dao = new VentaDAO();
            List<Venta> ventas = dao.obtenerTodasLasVentas();
            
            request.setAttribute("listaVentas", ventas);
            request.getRequestDispatcher("ConsultarVentas.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error listando ventas: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error al cargar las ventas");
            request.getRequestDispatcher("ConsultarVentas.jsp").forward(request, response);
        }
    }

    private void buscarVentas(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String fechaIni = request.getParameter("fechaIni");
        String fechaFin = request.getParameter("fechaFin");
        
        try {
            VentaDAO dao = new VentaDAO();
            List<Venta> ventas;
            
            if ((fechaIni != null && !fechaIni.isEmpty()) || (fechaFin != null && !fechaFin.isEmpty())) {
                ventas = dao.buscarVentasPorFecha(fechaIni, fechaFin);
            } else {
                ventas = dao.obtenerTodasLasVentas();
            }
            
            request.setAttribute("listaVentas", ventas);
            request.getRequestDispatcher("ConsultarVentas.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error buscando ventas: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error en la búsqueda");
            request.getRequestDispatcher("ConsultarVentas.jsp").forward(request, response);
        }
    }

    private void anularVenta(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idVentaStr = request.getParameter("id");
        
        try {
            if (idVentaStr != null && !idVentaStr.isEmpty()) {
                int idVenta = Integer.parseInt(idVentaStr);
                VentaDAO dao = new VentaDAO();
                boolean anulada = dao.anularVenta(idVenta);
                
                if (anulada) {
                    request.setAttribute("mensaje", "Venta anulada correctamente");
                } else {
                    request.setAttribute("error", "No se pudo anular la venta");
                }
            }
            
            listarVentas(request, response);
            
        } catch (Exception e) {
            System.err.println("Error anulando venta: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error al anular");
            request.getRequestDispatcher("ConsultarVentas.jsp").forward(request, response);
        }
    }
}