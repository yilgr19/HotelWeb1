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
                // 1. Recoger datos
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
                } catch (NumberFormatException e) { numHuespedes = 1; }

                // 2. VALIDACIÓN DE CAPACIDAD (REQUISITO: Simple=1, Doble=2, Suite=4)
                int capacidadMaxima = 10;
                if(tipoHabitacion != null) {
                    switch (tipoHabitacion.toLowerCase()) {
                        case "simple": capacidadMaxima = 1; break;
                        case "doble":  capacidadMaxima = 2; break;
                        case "suite":  capacidadMaxima = 4; break;
                    }
                }

                if (numHuespedes > capacidadMaxima) {
                    request.setAttribute("error", "Error: La habitación " + tipoHabitacion + 
                                         " permite máximo " + capacidadMaxima + " huéspedes.");
                    request.getRequestDispatcher("NuevaReserva.jsp").forward(request, response);
                    return; 
                }

                // 3. BUSCAR HABITACIÓN DISPONIBLE
                // Usamos el método corregido del DAO que ignora mayúsculas/minúsculas
                String habitacionAsignada = habitacionDao.obtenerHabitacionDisponible(tipoHabitacion);

                System.out.println("DEBUG SERVLET: Resultado búsqueda habitación: " + habitacionAsignada);

                if (habitacionAsignada == null) {
                    // SI ES NULL, MANDAMOS ERROR Y NO GUARDAMOS
                    request.setAttribute("error", "Lo sentimos, no hay habitaciones de tipo '" + 
                                         tipoHabitacion + "' disponibles en este momento.");
                } else {
                    // 4. SI HAY HABITACIÓN, PROCEDEMOS A GUARDAR
                    Reserva nuevaReserva = new Reserva(
                        fechaEntrada, horaEntrada, fechaSalida, horaSalida, 
                        tipoHabitacion, numHuespedes, habitacionAsignada, // Asignamos la encontrada
                        metodoPago, estadoReserva, cedula,
                        nombre, apellido, telefono 
                    );

                    if(reservaDao.registrarReserva(nuevaReserva)) {
                        request.setAttribute("mensaje", "¡Reserva Exitosa! Se ha asignado la habitación N°: " + habitacionAsignada);
                    } else {
                        request.setAttribute("error", "Error al guardar en base de datos.");
                    }
                }

            } else if ("Buscar".equals(accion)) {
                Reserva r = reservaDao.buscarReservaPorCedula(cedula);
                if (r != null) {
                    request.setAttribute("reservaEncontrada", r);
                    request.setAttribute("mensaje", "Datos cargados correctamente.");
                } else {
                    request.setAttribute("error", "No se encontró reserva con esa cédula.");
                }
                
            } else if ("Eliminar".equals(accion)) {
                // Primero obtenemos la reserva para saber qué habitación liberar
                Reserva r = reservaDao.buscarReservaPorCedula(cedula);
                
                if (r != null) {
                    if(reservaDao.eliminarReservaPorCedula(cedula)) {
                        // IMPORTANTE: Liberamos la habitación (volvemos a ponerla 'Disponible')
                        habitacionDao.cambiarEstadoHabitacion(r.getHabitacionAsignada(), "Disponible");
                        request.setAttribute("mensaje", "Reserva eliminada y habitación " + r.getHabitacionAsignada() + " liberada.");
                    } else {
                        request.setAttribute("error", "No se pudo eliminar la reserva.");
                    }
                } else {
                    request.setAttribute("error", "No existe reserva para eliminar con esa cédula.");
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error del sistema: " + e.getMessage());
        }

        request.getRequestDispatcher("NuevaReserva.jsp").forward(request, response);
    }
}