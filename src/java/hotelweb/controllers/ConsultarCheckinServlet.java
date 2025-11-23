package hotelweb.controllers;

import hotelweb.dao.CheckinDAO;
import hotelweb.models.Checkin;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ConsultarCheckinServlet", urlPatterns = {"/ConsultarCheckinServlet"})
public class ConsultarCheckinServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        CheckinDAO dao = new CheckinDAO();
        // Traemos TODO el historial (Activos y Finalizados)
        List<Checkin> lista = dao.listarHistorialCheckins();
        
        request.setAttribute("listaCheckins", lista);
        request.getRequestDispatcher("ConsultarCheckin.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}