package hotelweb.controllers;

import hotelweb.dao.CheckinDAO;
import hotelweb.models.Checkin;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "CheckinServlet", urlPatterns = {"/CheckinServlet"})
public class CheckinServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");
        CheckinDAO dao = new CheckinDAO();

        try {
            // CASO 1: BUSCAR RESERVA
            if ("buscar_reserva".equalsIgnoreCase(accion)) {
                String cedula = request.getParameter("cedula");
                Checkin datosPrevios = dao.buscarDatosPorCedula(cedula);
                
                if (datosPrevios != null) {
                    LocalDate entrada = null;
                    LocalDate salida = null;
                    long dias = 1;
                    try {
                        if (datosPrevios.getFechaEntrada() != null && datosPrevios.getFechaSalida() != null) {
                            DateTimeFormatter fGuiones = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                            DateTimeFormatter fBarras  = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                            
                            entrada = datosPrevios.getFechaEntrada().contains("-") ? 
                                      LocalDate.parse(datosPrevios.getFechaEntrada(), fGuiones) : 
                                      LocalDate.parse(datosPrevios.getFechaEntrada(), fBarras);
                                      
                            salida = datosPrevios.getFechaSalida().contains("-") ? 
                                     LocalDate.parse(datosPrevios.getFechaSalida(), fGuiones) : 
                                     LocalDate.parse(datosPrevios.getFechaSalida(), fBarras);
                                     
                            dias = ChronoUnit.DAYS.between(entrada, salida);
                            if (dias < 1) dias = 1;
                        }
                    } catch (Exception e) { dias = 1; }

                    double total = dias * datosPrevios.getPrecioNoche();
                    String fEntradaFinal = (entrada != null) ? entrada.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) : datosPrevios.getFechaEntrada();
                    String fSalidaFinal = (salida != null) ? salida.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) : datosPrevios.getFechaSalida();

                    Checkin calc = new Checkin(fEntradaFinal, datosPrevios.getHoraEntrada(), fSalidaFinal, datosPrevios.getHoraSalida(),
                            dias + " Días", datosPrevios.getNumHabitacion(), datosPrevios.getTipoHabitacion(),
                            datosPrevios.getPrecioNoche(), total, "Pendiente", datosPrevios.getClienteCedula(),
                            datosPrevios.getClienteNombre(), datosPrevios.getClienteApellido(), datosPrevios.getClienteTelefono(), "");
                    
                    request.setAttribute("checkinEncontrado", calc);
                    request.setAttribute("mensaje", "Datos calculados. Estadía: " + dias + " días.");
                } else {
                    request.setAttribute("error", "No se encontró reserva.");
                }
                request.getRequestDispatcher("NuevoCheckin.jsp").forward(request, response);

            // CASO 2: GUARDAR CHECK-IN
            } else if ("guardar_checkin".equalsIgnoreCase(accion)) {
                double precio = 0, total = 0;
                try {
                    precio = Double.parseDouble(request.getParameter("precioNoche"));
                    total = Double.parseDouble(request.getParameter("costoTotal"));
                } catch(Exception e){}

                Checkin nc = new Checkin(
                    request.getParameter("fechaEntrada"), request.getParameter("horaEntrada"),
                    request.getParameter("fechaSalida"), request.getParameter("horaSalida"),
                    request.getParameter("tiempoEstadia"), request.getParameter("numHabitacion"),
                    request.getParameter("tipoHabitacion"), precio, total,
                    request.getParameter("estadoPago"), request.getParameter("cedula"),
                    request.getParameter("nombre"), request.getParameter("apellido"),
                    request.getParameter("telefono"), request.getParameter("observaciones")
                );

                if (dao.registrarCheckin(nc)) {
                    request.setAttribute("mensaje", "Check-in Exitoso. Habitación " + nc.getNumHabitacion() + " ocupada.");
                } else {
                    request.setAttribute("error", "Error al guardar.");
                }
                request.getRequestDispatcher("NuevoCheckin.jsp").forward(request, response);

            // CASO 3: FINALIZAR CHECK-OUT (Desde la tabla de Consultas)
            } else if ("finalizar_checkout".equalsIgnoreCase(accion)) {
                int idCheckin = Integer.parseInt(request.getParameter("idCheckin"));
                String numHab = request.getParameter("numHabitacion");
                
                // Ejecutamos la salida
                boolean exito = dao.finalizarCheckin(idCheckin, numHab);
                
                // REDIRECCIONAMOS AL SERVLET DE CONSULTA para ver la tabla actualizada
                if(exito) {
                    // Usamos sendRedirect para limpiar la petición y recargar la lista
                    response.sendRedirect("ConsultarCheckinServlet");
                } else {
                    request.setAttribute("error", "Error al procesar la salida.");
                    request.getRequestDispatcher("NuevoCheckin.jsp").forward(request, response);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error Fatal: " + e.getMessage());
            request.getRequestDispatcher("NuevoCheckin.jsp").forward(request, response);
        }
    }
}