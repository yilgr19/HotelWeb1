package hotelweb.controllers;

import hotelweb.dao.CheckinDAO;
import hotelweb.models.Checkin;
import java.io.IOException;
// --- IMPORTS OBLIGATORIOS PARA LAS FECHAS ---
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
// --------------------------------------------
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "CheckinServlet", urlPatterns = {"/CheckinServlet"})
public class CheckinServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        CheckinDAO dao = new CheckinDAO();

        try {
            if ("buscar_reserva".equalsIgnoreCase(accion)) {
                String cedula = request.getParameter("cedula");
                Checkin datosPrevios = dao.buscarDatosPorCedula(cedula);
                
                if (datosPrevios != null) {
                    // 1. CORRECCIÓN: Inicializamos en NULL para que Java no se queje
                    LocalDate entrada = null;
                    LocalDate salida = null;
                    long dias = 1;

                    try {
                        // Validar que las fechas no sean nulas
                        if (datosPrevios.getFechaEntrada() == null || datosPrevios.getFechaSalida() == null) {
                            throw new Exception("Las fechas en la reserva están vacías.");
                        }

                        // Detectar formato (YYYY-MM-DD vs DD/MM/YYYY)
                        DateTimeFormatter formatoGuiones = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                        DateTimeFormatter formatoBarras  = DateTimeFormatter.ofPattern("dd/MM/yyyy");

                        // Intentamos parsear Entrada
                        if (datosPrevios.getFechaEntrada().contains("-")) {
                            entrada = LocalDate.parse(datosPrevios.getFechaEntrada(), formatoGuiones);
                        } else {
                            entrada = LocalDate.parse(datosPrevios.getFechaEntrada(), formatoBarras);
                        }

                        // Intentamos parsear Salida
                        if (datosPrevios.getFechaSalida().contains("-")) {
                            salida = LocalDate.parse(datosPrevios.getFechaSalida(), formatoGuiones);
                        } else {
                            salida = LocalDate.parse(datosPrevios.getFechaSalida(), formatoBarras);
                        }

                        // Calcular diferencia de días
                        dias = ChronoUnit.DAYS.between(entrada, salida);
                        if (dias < 1) dias = 1; 

                    } catch (Exception e) {
                        System.out.println("ADVERTENCIA: Error calculando fechas (" + e.getMessage() + "). Se usará 1 día por defecto.");
                        dias = 1; 
                    }

                    // --- CALCULO DE COSTOS ---
                    double precioNoche = datosPrevios.getPrecioNoche();
                    double total = dias * precioNoche;
                    
                    // --- PREPARAR OBJETO FINAL ---
                    // 2. CORRECCIÓN: Verificamos si es null antes de formatear
                    String fechaEntradaFinal = (entrada != null) ? entrada.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) : datosPrevios.getFechaEntrada();
                    String fechaSalidaFinal = (salida != null) ? salida.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) : datosPrevios.getFechaSalida();

                    Checkin checkinCalculado = new Checkin(
                        fechaEntradaFinal,
                        datosPrevios.getHoraEntrada(),
                        fechaSalidaFinal,
                        datosPrevios.getHoraSalida(),
                        dias + " Días", 
                        datosPrevios.getNumHabitacion(),
                        datosPrevios.getTipoHabitacion(),
                        precioNoche,
                        total, 
                        "Pendiente",
                        datosPrevios.getClienteCedula(),
                        datosPrevios.getClienteNombre(),
                        datosPrevios.getClienteApellido(),
                        datosPrevios.getClienteTelefono(),
                        ""
                    );
                    
                    request.setAttribute("checkinEncontrado", checkinCalculado);
                    request.setAttribute("mensaje", "Datos cargados. Estadía calculada: " + dias + " días.");
                    
                } else {
                    request.setAttribute("error", "No se encontró reserva confirmada para la cédula: " + cedula);
                }

            } else if ("guardar_checkin".equalsIgnoreCase(accion)) {
                String fechaEntrada = request.getParameter("fechaEntrada");
                String horaEntrada = request.getParameter("horaEntrada");
                String fechaSalida = request.getParameter("fechaSalida");
                String horaSalida = request.getParameter("horaSalida");
                String tiempoEstadia = request.getParameter("tiempoEstadia");
                String numHabitacion = request.getParameter("numHabitacion");
                String tipoHabitacion = request.getParameter("tipoHabitacion");
                
                double precioNoche = 0;
                double costoTotal = 0;
                try {
                     precioNoche = Double.parseDouble(request.getParameter("precioNoche"));
                     costoTotal = Double.parseDouble(request.getParameter("costoTotal"));
                } catch(NumberFormatException e) {
                    precioNoche = 0; costoTotal = 0;
                }
                
                String estadoPago = request.getParameter("estadoPago");
                String cedula = request.getParameter("cedula");
                String nombre = request.getParameter("nombre");
                String apellido = request.getParameter("apellido");
                String telefono = request.getParameter("telefono");
                String observaciones = request.getParameter("observaciones");

                Checkin nuevoCheckin = new Checkin(fechaEntrada, horaEntrada, fechaSalida, horaSalida, 
                        tiempoEstadia, numHabitacion, tipoHabitacion, precioNoche, costoTotal, estadoPago, 
                        cedula, nombre, apellido, telefono, observaciones);

                if (dao.registrarCheckin(nuevoCheckin)) {
                    request.setAttribute("mensaje", "Check-in registrado correctamente.");
                } else {
                    request.setAttribute("error", "Error al guardar en base de datos.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error General: " + e.getMessage());
        }

        request.getRequestDispatcher("NuevoCheckin.jsp").forward(request, response);
    }
}