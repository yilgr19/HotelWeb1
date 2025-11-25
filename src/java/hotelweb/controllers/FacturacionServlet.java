package hotelweb.controllers;

import hotelweb.dao.CheckinDAO;
import hotelweb.models.Checkin;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "FacturacionServlet", urlPatterns = {"/FacturacionServlet"})
public class FacturacionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        CheckinDAO dao = new CheckinDAO();

        try {
            if ("cobrar".equalsIgnoreCase(accion)) {
                int idCheckin = Integer.parseInt(request.getParameter("idCheckin"));
                double totalAPagar = Double.parseDouble(request.getParameter("totalAPagar"));
                
                // Obtener datos del check-in
                Checkin checkin = dao.obtenerCheckinPorId(idCheckin);
                
                if (checkin != null) {
                    // Actualizar el check-in como pagado
                    boolean actualizado = dao.actualizarEstadoPago(idCheckin, "Pagado");
                    
                    if (actualizado) {
                        // Redirigir a una página de confirmación
                        request.setAttribute("mensaje", "¡Cobro procesado exitosamente!");
                        request.setAttribute("cliente", checkin.getClienteNombre());
                        request.setAttribute("total", totalAPagar);
                        request.getRequestDispatcher("ConfirmacionPago.jsp").forward(request, response);
                    } else {
                        request.setAttribute("error", "Error al procesar el cobro.");
                        request.getRequestDispatcher("Facturacion.jsp?idCheckin=" + idCheckin).forward(request, response);
                    }
                } else {
                    request.setAttribute("error", "No se encontró el check-in.");
                    response.sendRedirect("ConsultarCheckin.jsp");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("ConsultarCheckin.jsp").forward(request, response);
        }
    }
}