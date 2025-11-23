package hotelweb.controllers;

import hotelweb.dao.ReservaDAO;
import hotelweb.models.Reserva;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ConsultarServlet", urlPatterns = {"/ConsultarServlet"})
public class ConsultarServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Llamamos al DAO para obtener la lista
        ReservaDAO dao = new ReservaDAO();
        List<Reserva> lista = dao.listarReservas();
        
        // 2. Pasamos la lista al JSP
        request.setAttribute("listaReservas", lista);
        
        // 3. Enviamos a la página de visualización
        request.getRequestDispatcher("ConsultarReserva.jsp").forward(request, response);
    }
}