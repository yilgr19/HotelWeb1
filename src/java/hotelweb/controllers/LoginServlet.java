package hotelweb.controllers;

// Imports de Java
import hotelweb.dao.UsuarioManager;
import hotelweb.models.Usuario;
import java.io.IOException;

// Imports de Servlet (javax)
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

// ¡¡IMPORTS IMPORTANTES DE TU LÓGICA!!

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Obtenemos los datos del formulario (de index.jsp)
        String username = request.getParameter("txtUsuario");
        String password = request.getParameter("txtPassword");

        // 2. ¡¡AQUÍ ESTÁ EL CAMBIO!!
        // Ya no usamos un 'if' simple, llamamos a tu UsuarioManager
        Usuario usuarioValidado = UsuarioManager.autenticarUsuario(username, password);

        // 3. Comprobamos si el manager encontró al usuario
        if (usuarioValidado != null) {
            // USUARIO VÁLIDO

            // 1. Creamos la sesión
            HttpSession session = request.getSession(true);
            
            // 2. Guardamos el OBJETO Usuario completo en la sesión.
            //    Esto es mucho mejor, porque ahora podemos acceder al ROL
            //    y al nombre real (ej. "Camilo Ramirez") en otras páginas.
            session.setAttribute("usuarioLogueado", usuarioValidado); 
            
            // 3. Redirigimos a la página principal
            // ¡¡CAMBIA "dashboard.jsp" POR TU PÁGINA PRINCIPAL!!
            response.sendRedirect("Menu.jsp"); 

        } else {
            // USUARIO INVÁLIDO (autenticarUsuario devolvió null)
            
            // 1. Creamos un mensaje de error
            request.setAttribute("error", "Usuario o contraseña incorrectos.");
            
            // 2. Te devolvemos al login (index.jsp)
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}