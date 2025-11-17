package hotelweb.controllers;

import hotelweb.dao.ClienteDAO;
import hotelweb.models.Cliente;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Este servlet actúa como el "Gerente" o "Cerebro"
 * para TODAS las acciones del formulario de Clientes.
 */
public class ClienteServlet extends HttpServlet {

    /**
     * Maneja las peticiones POST (los envíos de formulario)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 0. Usar UTF-8 para tildes y eñes
        request.setCharacterEncoding("UTF-8");

        // 1. Identificamos la ACCIÓN que el usuario quiere hacer
        String accion = request.getParameter("accion");
        if (accion == null) accion = ""; // Evitar error null

        // 2. Creamos el "Trabajador" de base de datos
        ClienteDAO dao = new ClienteDAO();
        
        // 3. Leemos la Cédula (la usamos en casi todas las acciones)
        String cedula = request.getParameter("cedula"); 

        try {
            
            // <-- ======================================================= -->
            // <-- AQUÍ ES DONDE EMPIEZA EL CÓDIGO QUE TÚ PEGASTE (EL SWITCH) -->
            // <-- ======================================================= -->
            
            switch (accion) {
                
                case "guardar":
                    // Leemos el resto de los campos del formulario
                    String nombre = request.getParameter("nombre");
                    String apellido = request.getParameter("apellido");
                    String telefono = request.getParameter("telefono");
                    String direccion = request.getParameter("direccion");
                    String correo = request.getParameter("correo");

                    // Creamos el "molde" (Cliente)
                    Cliente cliente = new Cliente(cedula, nombre, apellido, telefono, direccion, correo);
                    
                    // (Lógica futura: aquí podrías revisar si el cliente ya existe
                    // para llamar a 'dao.actualizarCliente(cliente)' en lugar de registrar)
                    
                    // Llamamos al DAO para que lo guarde
                    dao.registrarCliente(cliente);
                    
                    // Enviamos un mensaje de éxito de vuelta al JSP
                    request.setAttribute("mensaje", "¡Cliente " + nombre + " guardado con éxito!");
                    break;

                case "buscar":
                    // Llamamos al DAO para que busque por cédula
                    Cliente clienteEncontrado = dao.buscarPorCedula(cedula);
                    
                    if (clienteEncontrado != null) {
                        // Si lo encontramos, lo enviamos al JSP para rellenar el formulario
                        request.setAttribute("clienteEncontrado", clienteEncontrado);
                        request.setAttribute("mensaje", "Cliente " + clienteEncontrado.getNombre() + " encontrado.");
                    } else {
                        request.setAttribute("error", "No se encontró ningún cliente con la cédula " + cedula);
                    }
                    break;

                case "eliminar":
                    // Llamamos al DAO para que elimine por cédula
                    if (dao.eliminarPorCedula(cedula)) {
                        request.setAttribute("mensaje", "Cliente con cédula " + cedula + " eliminado.");
                    } else {
                        request.setAttribute("error", "No se pudo eliminar el cliente con cédula " + cedula);
                    }
                    break;
                    
                default:
                    // Si el botón no tiene un 'value' (ej. "guardar", "buscar", "eliminar")
                    request.setAttribute("error", "Acción desconocida.");
            }
            
            // <-- ======================================================= -->
            // <-- AQUÍ ES DONDE TERMINA EL BLOQUE 'try'                   -->
            // <-- ======================================================= -->
            
        } catch (SQLException e) {
            // Si algo falla en la Base de Datos (ej. Cédula duplicada)
            e.printStackTrace(); // Muestra el error en la consola de NetBeans
            request.setAttribute("error", "Error de Base de Datos: " + e.getMessage());
        }

        // 4. Al final de TODO (sea éxito o error), SIEMPRE reenviamos
        // de vuelta al formulario JSP.
        // (El JSP usará los 'setAttribute' para mostrar los mensajes)
        request.getRequestDispatcher("NuevoCliente.jsp").forward(request, response);
    }
}