package hotelweb.controllers;

import hotelweb.dao.HabitacionDAO;
import hotelweb.models.Habitacion;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "HabitacionServlet", urlPatterns = {"/HabitacionServlet"})
public class HabitacionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        String accion = request.getParameter("accion");
        String numero = request.getParameter("numero"); // Campo clave
        
        HabitacionDAO dao = new HabitacionDAO();
        String mensaje = null;
        String error = null;

        try {
            if ("guardar".equalsIgnoreCase(accion)) {
                String tipo = request.getParameter("tipo");
                String precioStr = request.getParameter("precio");
                String estado = request.getParameter("estado");
                
                double precio = Double.parseDouble(precioStr); // Convertimos texto a numero
                
                Habitacion h = new Habitacion(numero, tipo, precio, estado);
                if (dao.guardarHabitacion(h)) {
                    mensaje = "Habitación " + numero + " guardada correctamente.";
                } else {
                    error = "Error al guardar. Verifique si el número ya existe.";
                }

            } else if ("buscar".equalsIgnoreCase(accion)) {
                Habitacion h = dao.buscarHabitacion(numero);
                if (h != null) {
                    request.setAttribute("habitacionEncontrada", h);
                    mensaje = "Habitación encontrada.";
                } else {
                    error = "No se encontró la habitación " + numero;
                }

            } else if ("eliminar".equalsIgnoreCase(accion)) {
                if (dao.eliminarHabitacion(numero)) {
                    mensaje = "Habitación eliminada correctamente.";
                } else {
                    error = "No se pudo eliminar.";
                }
            }
        } catch (NumberFormatException e) {
            error = "El precio debe ser un número válido.";
        } catch (Exception e) {
            error = "Error del sistema: " + e.getMessage();
        }

        request.setAttribute("mensaje", mensaje);
        request.setAttribute("error", error);
        request.getRequestDispatcher("NuevaHabitacion.jsp").forward(request, response);
    }
}