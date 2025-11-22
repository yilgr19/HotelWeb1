package hotelweb.controllers;

import hotelweb.dao.ReservaDAO;
import hotelweb.models.Reserva;
import hotelweb.dao.ClienteDAO;
import hotelweb.models.Cliente;

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
        
        // 1. Asegurar caracteres latinos (ñ, tildes)
        request.setCharacterEncoding("UTF-8");

        // 2. Obtener la acción del botón
        String accion = request.getParameter("accion");
        
        // 3. Obtener la cédula (dato común para todas las acciones)
        String cedula = request.getParameter("cedula");

        // --- ZONA DE DEPURACIÓN (Mira esto en el Output de NetBeans) ---
        System.out.println("=======================================");
        System.out.println("DEBUG: Entrando al Servlet");
        System.out.println("DEBUG: Acción recibida = " + accion);
        System.out.println("DEBUG: Cédula recibida = " + cedula);
        System.out.println("=======================================");
        // --------------------------------------------------------------

        ReservaDAO reservaDao = new ReservaDAO();
        ClienteDAO clienteDao = new ClienteDAO(); 

        try {
            if (accion != null) {
                switch (accion) {
                    case "Reservar":
                        // Recibir parámetros del formulario
                        String fechaEntrada = request.getParameter("fechaEntrada");
                        String horaEntrada  = request.getParameter("horaEntrada");
                        String fechaSalida  = request.getParameter("fechaSalida");
                        String horaSalida   = request.getParameter("horaSalida");
                        String tipoHabitacion = request.getParameter("tipoHabitacion");
                        String habitacionAsignada = request.getParameter("habitacionAsignada");
                        String metodoPago = request.getParameter("metodoPago");
                        String estadoReserva = request.getParameter("estadoReserva");
                        
                        // Conversión segura de número de huéspedes
                        int numHuespedes = 1;
                        try {
                            String paramHuespedes = request.getParameter("numHuespedes");
                            if(paramHuespedes != null && !paramHuespedes.isEmpty()){
                                numHuespedes = Integer.parseInt(paramHuespedes);
                            }
                        } catch (NumberFormatException e) {
                            System.out.println("DEBUG: Error al convertir huespedes, usando valor por defecto 1.");
                            numHuespedes = 1; 
                        }
                        
                        // DEBUG ADICIONAL PARA VER SI LLEGAN LOS DATOS
                        System.out.println("DEBUG: Intentando guardar fechaEntrada: " + fechaEntrada);

                        Reserva nuevaReserva = new Reserva(
                            fechaEntrada, horaEntrada, fechaSalida, horaSalida, 
                            tipoHabitacion, numHuespedes, habitacionAsignada, 
                            metodoPago, estadoReserva, cedula
                        );

                        if(reservaDao.registrarReserva(nuevaReserva)) {
                            request.setAttribute("mensaje", "¡Reserva creada con éxito para la cédula: " + cedula + "!");
                            System.out.println("DEBUG: Reserva guardada OK");
                        } else {
                             request.setAttribute("error", "No se pudo crear la reserva. Verifique que el cliente con cédula " + cedula + " exista.");
                             System.out.println("DEBUG: Falló al guardar (posiblemente cliente no existe)");
                        }
                        break;

                    case "Buscar":
                        System.out.println("DEBUG: Buscando reserva...");
                        Reserva r = reservaDao.buscarReservaPorCedula(cedula);
                        if (r != null) {
                            request.setAttribute("reservaEncontrada", r);
                            request.setAttribute("mensaje", "Reserva encontrada.");
                        }
                        
                        Cliente c = clienteDao.buscarPorCedula(cedula);
                        if (c != null) {
                            request.setAttribute("clienteEncontrado", c);
                        } else {
                            if(r == null) request.setAttribute("error", "No se encontró nada con esa cédula.");
                        }
                        break;

                    case "Eliminar":
                        System.out.println("DEBUG: Eliminando reserva...");
                        if (reservaDao.eliminarReservaPorCedula(cedula)) {
                            request.setAttribute("mensaje", "Reserva eliminada.");
                        } else {
                            request.setAttribute("error", "No se pudo eliminar o no existía reserva.");
                        }
                        break;
                        
                    default:
                        request.setAttribute("error", "Acción no reconocida: " + accion);
                        break;
                }
            } else {
                // Si accion es null
                request.setAttribute("error", "El botón no envió ninguna acción (accion es null).");
                System.out.println("DEBUG: ERROR FATAL - accion es NULL");
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Esto imprime el error real en la consola
            System.out.println("DEBUG: EXCEPCIÓN SQL: " + e.getMessage());
            request.setAttribute("error", "Error de Base de Datos: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error inesperado: " + e.getMessage());
        }

        // Redireccionar de vuelta al JSP
        request.getRequestDispatcher("NuevaReserva.jsp").forward(request, response);
    }
}