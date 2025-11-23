package hotelweb.controllers;

import hotelweb.dao.ReservaDAO;
import hotelweb.dao.HabitacionDAO;
import hotelweb.models.Reserva;
import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ReservaServlet", urlPatterns = {"/ReservaServlet"})
public class ReservaServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        String cedula = request.getParameter("cedula");
        
        ReservaDAO reservaDao = new ReservaDAO();
        HabitacionDAO habitacionDao = new HabitacionDAO();

        try {
            if ("Reservar".equals(accion)) {
                String fechaEntrada = request.getParameter("fechaEntrada");
                String horaEntrada  = request.getParameter("horaEntrada");
                String fechaSalida  = request.getParameter("fechaSalida");
                String horaSalida   = request.getParameter("horaSalida");
                String tipoHabitacion = request.getParameter("tipoHabitacion");
                String metodoPago = request.getParameter("metodoPago");
                String estadoReserva = request.getParameter("estadoReserva");
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String telefono = request.getParameter("telefono");
                
                int numHuespedes = 1;
                try {
                    numHuespedes = Integer.parseInt(request.getParameter("numHuespedes"));
                } catch (NumberFormatException e) {}

                // Validar Capacidad
                int max = 10;
                if(tipoHabitacion != null) {
                    switch(tipoHabitacion.toLowerCase()) {
                        case "simple": max=1; break;
                        case "doble": max=2; break;
                        case "suite": max=4; break;
                    }
                }
                if(numHuespedes > max) {
                    request.setAttribute("error", "Error: " + tipoHabitacion + " permite máx. " + max + " personas.");
                    request.getRequestDispatcher("NuevaReserva.jsp").forward(request, response);
                    return;
                }

                // Asignar Habitación
                String habitacionAsignada = habitacionDao.obtenerHabitacionDisponible(tipoHabitacion);

                if (habitacionAsignada == null) {
                    request.setAttribute("error", "No hay habitaciones " + tipoHabitacion + " disponibles.");
                } else {
                    Reserva r = new Reserva(fechaEntrada, horaEntrada, fechaSalida, horaSalida, 
                            tipoHabitacion, numHuespedes, habitacionAsignada, metodoPago, estadoReserva, cedula,
                            nombre, apellido, telefono); // Pasamos los datos del cliente

                    if(reservaDao.registrarReserva(r)) {
                        request.setAttribute("mensaje", "Reserva Exitosa. Habitación: " + habitacionAsignada);
                    } else {
                        request.setAttribute("error", "Error al guardar en BD.");
                    }
                }

            } else if ("Buscar".equals(accion)) {
                Reserva r = reservaDao.buscarReservaPorCedula(cedula);
                if (r != null) {
                    request.setAttribute("reservaEncontrada", r);
                    request.setAttribute("mensaje", "Datos encontrados.");
                } else {
                    request.setAttribute("error", "No se encontró reserva.");
                }

            } else if ("Eliminar".equals(accion)) {
                if (reservaDao.eliminarReservaPorCedula(cedula)) {
                    request.setAttribute("mensaje", "Reserva eliminada.");
                } else {
                    request.setAttribute("error", "No se pudo eliminar.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
        }

        request.getRequestDispatcher("NuevaReserva.jsp").forward(request, response);
    }
}