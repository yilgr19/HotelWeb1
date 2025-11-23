<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="hotelweb.models.Usuario" %>
<%@ page import="hotelweb.dao.UsuarioManager" %>
<%@ page import="hotelweb.models.Checkin" %>
<%@ page import="java.util.List" %>

<%
    Usuario usuarioLogueado = (Usuario) session.getAttribute("usuarioLogueado");
    if (usuarioLogueado == null) {
        response.sendRedirect("index.jsp?error=sesion_expirada");
        return;
    }
    List<Checkin> lista = (List<Checkin>) request.getAttribute("listaCheckins");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Consulta de Check-ins</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <style>
        body { background-color: #343a40; min-height: 100vh; display: flex; justify-content: center; align-items: center; padding: 20px 0; }
        .form-dark-card { max-width: 1400px; width: 95%; background-color: #212529; border: none; }
        .table-dark-custom { background-color: #212529; color: #dee2e6; }
        .table-dark-custom th { background-color: #000; color: #fff; border-color: #373b3e; text-align: center; }
        .table-dark-custom td { border-color: #373b3e; vertical-align: middle; text-align: center; }
    </style>
</head>
<body>
    
    <div class="card form-dark-card text-white shadow-lg rounded-3">
        <div class="card-header bg-black text-center py-3 rounded-top-3">
            <h2 class="mb-0">Control de Check-ins y Salidas</h2>
        </div>
        
        <div class="card-body">
            <div class="row mb-3">
                <div class="col-md-6 d-flex gap-2">
                    <a href="Menu.jsp" class="btn btn-secondary">Regresar al Menú</a>
                    <a href="NuevoCheckin.jsp" class="btn btn-primary">Nuevo Check-in</a>
                    <a href="ConsultarCheckinServlet" class="btn btn-info text-white">Actualizar Tabla</a>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-hover table-dark-custom table-bordered">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Hab</th>
                            <th>Cédula</th>
                            <th>Huésped</th>
                            <th>Entrada</th>
                            <th>Salida Prevista</th>
                            <th>Salida Real</th>
                            <th>Total</th>
                            <th>Estado</th>
                            <th>Acciones / Check-out</th> </tr>
                    </thead>
                    <tbody>
                        <% 
                        if (lista != null && !lista.isEmpty()) {
                            for (Checkin c : lista) {
                                // Recuperamos el estado (Activo/Finalizado)
                                // NOTA: En el DAO guardamos el estado en el campo TiempoEstadia o Observaciones
                                String estado = c.getTiempoEstadia(); 
                                String fechaReal = c.getObservaciones();
                                
                                boolean esActivo = "Activo".equalsIgnoreCase(estado);
                                String filaClass = esActivo ? "" : "opacity-75"; // Oscurecer un poco los finalizados
                        %>
                            <tr class="<%= filaClass %>">
                                <td><%= c.getIdCheckin() %></td>
                                <td class="text-info fw-bold"><%= c.getNumHabitacion() %></td>
                                <td><%= c.getClienteCedula() %></td>
                                <td class="text-start"><%= c.getClienteNombre() + " " + c.getClienteApellido() %></td>
                                <td><%= c.getFechaEntrada() %></td>
                                <td class="text-warning"><%= c.getFechaSalida() %></td>
                                <td><%= fechaReal %></td>
                                <td>$<%= c.getCostoTotal() %></td>
                                <td>
                                    <% if(esActivo) { %>
                                        <span class="badge bg-success">Hospedado</span>
                                    <% } else { %>
                                        <span class="badge bg-secondary">Finalizado</span>
                                    <% } %>
                                </td>
                                
                                <td>
                                    <% if(esActivo) { %>
                                        <form action="CheckinServlet" method="post" onsubmit="return confirm('¿Confirmar salida? Se liberará la habitación <%= c.getNumHabitacion() %>.');">
                                            <input type="hidden" name="accion" value="finalizar_checkout">
                                            <input type="hidden" name="idCheckin" value="<%= c.getIdCheckin() %>">
                                            <input type="hidden" name="numHabitacion" value="<%= c.getNumHabitacion() %>">
                                            
                                            <button type="submit" class="btn btn-danger btn-sm fw-bold w-100">
                                                <i class="bi bi-box-arrow-right"></i> Salida
                                            </button>
                                        </form>
                                    <% } else { %>
                                        <span class="text-success"><i class="bi bi-check-circle-fill"></i> Completado</span>
                                    <% } %>
                                </td>
                            </tr>
                        <% 
                            } 
                        } else { 
                        %>
                            <tr>
                                <td colspan="10" class="text-center text-muted py-5">
                                    <h4>No hay registros.</h4>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="card-footer text-end text-muted py-2 bg-black rounded-bottom-3">
            <small>Gestión Hotelera</small>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>