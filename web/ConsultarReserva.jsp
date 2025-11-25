<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="hotelweb.models.Usuario" %>
<%@ page import="hotelweb.models.Reserva" %>
<%@ page import="java.util.List" %>

<%
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");
    if (usuarioLogueado == null) {
        response.sendRedirect("index.jsp?error=sesion_expirada");
        return;
    }
    
    // RECUPERAR LA LISTA DEL SERVLET
    List<Reserva> lista = (List<Reserva>) request.getAttribute("listaReservas");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Consulta de Reservas</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #343a40; color: white; padding: 20px; }
        .table-dark-custom { background-color: #212529; color: white; }
    </style>
</head>
<body>
    
    <div class="container mt-4">
        <h2 class="text-center mb-4">Listado de Reservas</h2>
        
        <div class="mb-3">
             <a href="Menu.jsp" class="btn btn-info">Regresar al Menú</a>
             <a href="NuevaReserva.jsp" class="btn btn-light">Nueva Reserva</a>
        </div>

        <div class="table-responsive">
            <table class="table table-hover table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Cédula</th>
                        <th>Cliente</th>
                        <th>Teléfono</th>
                        <th>Habitación</th>
                        <th>Entrada</th>
                        <th>Salida</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    if (lista != null && !lista.isEmpty()) {
                        for (Reserva r : lista) {
                            // LÓGICA DE COLORES
                            // Confirmada = Verde (table-success)
                            // Pendiente = Blanco (sin clase o table-light)
                            String claseColor = "";
                            String textoEstado = r.getEstadoReserva();
                            
                            if ("Confirmada".equalsIgnoreCase(textoEstado)) {
                                claseColor = "table-success"; // Verde Bootstrap
                            } else {
                                claseColor = "table-light";   // Blanco/Gris claro
                            }
                    %>
                        <tr class="<%= claseColor %>">
                            <td><%= r.getIdReserva() %></td>
                            <td><%= r.getCedulaCliente() %></td>
                            <td><%= r.getClienteNombre() + " " + r.getClienteApellido() %></td>
                            <td><%= r.getClienteTelefono() %></td>
                            <td class="fw-bold"><%= r.getHabitacionAsignada() %></td>
                            <td><%= r.getFechaEntrada() %></td>
                            <td><%= r.getFechaSalida() %></td>
                            <td class="fw-bold"><%= textoEstado %></td>
                            <td>
                                <form action="ReservaServlet" method="post" style="display:inline;">
                                    <input type="hidden" name="cedula" value="<%= r.getCedulaCliente() %>">
                                    <button type="submit" name="accion" value="Buscar" class="btn btn-success">Gestionar</button>
                                </form>
                            </td>
                        </tr>
                    <% 
                        } 
                    } else { 
                    %>
                        <tr>
                            <td colspan="9" class="text-center text-white bg-secondary">
                                No hay reservas registradas o no se cargaron los datos.
                                <br>
                                <small>Asegúrese de entrar desde el botón "Consultar" del menú.</small>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>