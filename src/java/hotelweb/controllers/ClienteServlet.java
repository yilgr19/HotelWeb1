package hotelweb.controllers;

import hotelweb.dao.ClienteDAO;
import hotelweb.models.Cliente;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ClienteServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");

        // 1. Identificamos la ACCIÓN que el usuario quiere hacer
        String accion = request.getParameter("accion");
        if (accion == null) accion = ""; // Evitar error null

        ClienteDAO dao = new ClienteDAO();
        // Leemos la cédula (¡el nombre correcto del formulario!)
        String cedula = request.getParameter("cedula"); 

        try {
            switch (accion) {
                case "guardar":
                    // Leemos TODOS los campos del formulario (¡con los nombres correctos!)
                    String nombre = request.getParameter("nombre");
                    String apellido = request.getParameter("apellido");
                    String telefono = request.getParameter("telefono");
                    String direccion = request.getParameter("direccion"); // <-- El campo que faltaba
                    String correo = request.getParameter("correo");       // <-- El campo que faltaba

                    // ¡AQUÍ ESTÁ EL ARREGLO! (Línea 36 de tu error)
                    // Creamos el cliente usando el constructor de 6 ARGUMENTOS
                    Cliente cliente = new Cliente(cedula, nombre, apellido, telefono, direccion, correo);
                    
                    // (Aquí faltaría la lógica de "Actualizar" si el cliente ya existe)
                    
                    // Llamamos al DAO
                    dao.registrarCliente(cliente);
                    
                    // Enviamos un mensaje de éxito
                    request.setAttribute("mensaje", "¡Cliente " + nombre + " guardado con éxito!");
                    break;

                case "buscar":
                    Cliente clienteEncontrado = dao.buscarPorCedula(cedula);
                    
                    if (clienteEncontrado != null) {
                        request.setAttribute("clienteEncontrado", clienteEncontrado);
                        request.setAttribute("mensaje", "Cliente " + clienteEncontrado.getNombre() + " encontrado.");
                    } else {
                        request.setAttribute("error", "No se encontró ningún cliente con la cédula " + cedula);
                    }
                    break;

                case "eliminar":
                    if (dao.eliminarPorCedula(cedula)) {
                        request.setAttribute("mensaje", "Cliente con cédula " + cedula + " eliminado.");
                    } else {
                        request.setAttribute("error", "No se pudo eliminar el cliente con cédula " + cedula);
                    }
                    break;
                    
                default:
                    request.setAttribute("error", "Acción desconocida.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error de Base de Datos: " + e.getMessage());
        }

        // 6. Al final, SIEMPRE reenviamos al formulario
        request.getRequestDispatcher("NuevoCliente.jsp").forward(request, response);
    }
}